module 0x24d391e8f24456a4f19fdefb6273472f072140edb868d004eb6779abe928b80::ruggy {
    struct RUGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUGGY>(arg0, 6, b"RUGGY", b"RuggyThe RuggFucker", b"Ruggy the Rugg Fucker - $Fucker", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000026456_84ee2a2394.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

