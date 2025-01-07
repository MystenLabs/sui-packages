module 0x80642ba4702ba76290d14c079c032f60a7f71a6a269dfac3106e452295f119ef::kamala {
    struct KAMALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAMALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAMALA>(arg0, 6, b"KAMALA", b"sKAMALA", b"KAMALA FOR PRESIDENT AND CRYPTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_e0c0fc27d8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAMALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAMALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

