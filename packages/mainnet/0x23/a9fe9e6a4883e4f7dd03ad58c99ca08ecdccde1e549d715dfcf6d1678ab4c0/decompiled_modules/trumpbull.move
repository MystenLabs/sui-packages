module 0x23a9fe9e6a4883e4f7dd03ad58c99ca08ecdccde1e549d715dfcf6d1678ab4c0::trumpbull {
    struct TRUMPBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPBULL>(arg0, 9, b"TRUMPBULL", b"UPTRUMP", b"Donal Trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/536c71ce-454f-46db-8d54-e38e676fc507.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

