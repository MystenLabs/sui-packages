module 0x5672d7334496c1e565cacbfccce868d5e4de0825069a85aaf5b322486af08027::sbagy {
    struct SBAGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBAGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBAGY>(arg0, 6, b"SBAGY", b"Sui Bagy", b"Grab your bag and join the leap to greatness with Bagy! https://t.me/BagySui_Portal | https://bagysui.site | https://x.com/BaggySui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_4_99423b15e1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBAGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBAGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

