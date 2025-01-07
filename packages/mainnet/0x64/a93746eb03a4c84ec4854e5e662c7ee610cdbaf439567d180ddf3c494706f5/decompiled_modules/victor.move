module 0x64a93746eb03a4c84ec4854e5e662c7ee610cdbaf439567d180ddf3c494706f5::victor {
    struct VICTOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: VICTOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VICTOR>(arg0, 6, b"VICTOR", b"Victor Finance", b"Magic defeat magic.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wechat_IMG_111_1ee540062d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VICTOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VICTOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

