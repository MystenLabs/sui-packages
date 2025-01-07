module 0x5ebdeb63bb4daa5a4108db01f6a1b8202f916da939db92c3255db3e43d65db7::amazon {
    struct AMAZON has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMAZON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMAZON>(arg0, 6, b"Amazon", b"Melania Amazon", x"496620796f75206c6f7665206f757220666f726d6572204669727374204c616479206173206d756368206173206d652c20616e642061726520726561647920666f72207468652054727574682c2062757920686572206e657720626f6f6b206e6f7721204d454c414e49412070726f766964657320616e20696e736967687466756c207065727370656374697665206f66206865722074656e757265206173204669727374204c616479206f662074686520556e69746564205374617465732c20686967686c69676874696e67206f7572207368617265640a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Amazon_TK_Cy2j_1cp_Uh_P_Wkhmof_a73314c14f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMAZON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMAZON>>(v1);
    }

    // decompiled from Move bytecode v6
}

