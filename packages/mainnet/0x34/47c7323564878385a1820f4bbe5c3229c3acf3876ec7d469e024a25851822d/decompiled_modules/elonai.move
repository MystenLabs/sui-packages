module 0x3447c7323564878385a1820f4bbe5c3229c3acf3876ec7d469e024a25851822d::elonai {
    struct ELONAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ELONAI>(arg0, 6, b"ELONAI", b"Official ElonAi by SuiAI", b"Combination of two narratives ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/photo_output_2bdb6b6856.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ELONAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

