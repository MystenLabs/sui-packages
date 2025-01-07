module 0xc09a16ff0cb8cad97e1b3d7687eed3b7fd3a3f238c8e7a65aab78ad6ab3d154a::cheems {
    struct CHEEMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEEMS>(arg0, 6, b"CHEEMS", b"CHEEMS SUI", x"436865656d732024434845454d53206e6f74206f6e6c7920656d626f646965732074686520737069726974206f66207468652069636f6e696320536869626120496e75206d656d652062757420616c736f206861726e657373657320697473206d656d6520706f74656e7469616c20746f2063726561746520612064796e616d696320616e6420656e676167696e6720636f6d6d756e6974792e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/catclub_7e173cc471.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEEMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEEMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

