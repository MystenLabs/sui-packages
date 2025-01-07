module 0xe14f5b17e7d900c941ad00e0981652001df994478d9827cb2eb346cd73ed7339::noco {
    struct NOCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOCO>(arg0, 6, b"NOCO", b"Noco", b"Where the cutest creatures are all gathered", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730977392947.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOCO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOCO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

