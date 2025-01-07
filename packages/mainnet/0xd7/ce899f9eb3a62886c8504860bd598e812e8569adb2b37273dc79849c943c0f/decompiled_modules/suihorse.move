module 0xd7ce899f9eb3a62886c8504860bd598e812e8569adb2b37273dc79849c943c0f::suihorse {
    struct SUIHORSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHORSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHORSE>(arg0, 6, b"SUIHORSE", b"Sea Horse on SUI", x"5468652053696c656e7420477561726469616e206f662074686520556e6465727761746572205265616c6d2c207768657265206c6567656e64732064726966742077697468207468652074696465732e0a0a68747470733a2f2f782e636f6d2f737569686f7273657375690a68747470733a2f2f742e6d652f737569686f7273657375690a68747470733a2f2f737569686f7273652e78797a2f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/instant_70_3cee2bc37f.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHORSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIHORSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

