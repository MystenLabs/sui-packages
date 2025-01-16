module 0x16ac9feb7cd0424b1ba8fc0e77b3b367b71a1943cbc7b3011a499a212457ba34::fredai {
    struct FREDAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREDAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FREDAI>(arg0, 6, b"FREDAI", b"Fred Ai by SuiAI", b"Meet Fred .. $Fredai  Beta now live !   Interact with Fred in game !   Play games with Fred, gift Fred or Fred can gift you .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2166_b22eeb819a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FREDAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREDAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

