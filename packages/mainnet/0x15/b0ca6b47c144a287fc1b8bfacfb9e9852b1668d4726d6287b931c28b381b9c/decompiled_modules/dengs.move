module 0x15b0ca6b47c144a287fc1b8bfacfb9e9852b1668d4726d6287b931c28b381b9c::dengs {
    struct DENGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DENGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DENGS>(arg0, 6, b"DENGs", b"MooDeng on Sui", b"Baby hippo gone viral. Now on sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_c9d90e72a5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DENGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DENGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

