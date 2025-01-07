module 0x806d0a4b1f0f22f15ee58247ed773fa320f58c5289203f5e7030db51e015183a::sup {
    struct SUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUP>(arg0, 6, b"SUP", b"super ultra pro chill guy", b"its just a Super ultra pro  chill guy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/I_I_I_I_I_I_I_I_I_I_I_I_I_I_I_I_I_2024_12_05_224329_e298e1b20e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

