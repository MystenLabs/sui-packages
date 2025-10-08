module 0x61432b62e8c9a545cd6c5441dedc482fd83cfee3f816751a9b43c8df5499761a::govex {
    struct GOVEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOVEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<GOVEX>(arg0, 6, b"GOVEX", b"Govex", b"The native token for the Govex Protocol", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRlgBAABXRUJQVlA4IEwBAAAQDwCdASqAAIAAPm0qkEYkIiGhLh7YqIANiWknAAJONFiAq+AdKENvvKaS79mDFD4KAIEn5w+3hNfNyQ5z7H9y+GK5PL0zx311qTpgkvqiNrsTxgEKVLsZChtUyq3KQ8/wDGn9rc41fC9ebG/iORmdmE3wflAFLiVeugLNuKfhRAAA/vozrZl1nDaDxWaMvvoI/NdrxpWwJCp3VHsP+xs+8od7j1eA84ST2/H9OdGC9czGZhZc2VLqTCOBZwEly34pfQjNa1EXCaMrOey4kmYSXuhpEfzK3Wf9zKxpjDeVwETrF+9jG+PRqsc6IVudPsxirj8IS/zxhqAeqFRFkjj8kjB40LhcZzF2NDBmbifNgp0uBDsv+u40b4evsh/b0A/MB5S6BRbs6MqLr7If9yiqZgNPEsZD+wOg+DpHMBmnXptB9NJfuAKYCAAAAA=="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOVEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOVEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

