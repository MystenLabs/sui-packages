module 0xada0325100c678b039c9ec7ee98750bf1c720e61ed7a265b7b36ab9e866c9a90::snork {
    struct SNORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNORK>(arg0, 6, b"Snork", b"Snorkz", b"A group of magical creatures embark on wonderful adventures in the depths of the ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731748823793.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNORK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNORK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

