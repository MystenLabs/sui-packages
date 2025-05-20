module 0x62a90180c093203db8c4647b72599436bc906d191651317742f10fa4660e1eda::aquanite {
    struct AQUANITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUANITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUANITE>(arg0, 6, b"Aquanite", b"Aquanite sui", x"74696e792070726f6a65637420617274776f726b207365656b207072657474792068696464656e206172742063617375616c2073687566666c6520666f7274756e65c2a073696c6c79c2a0726564756365", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiab4x47f44jig6e2zqbagkvbpeivuhghw6k7eomrcs4dpwd4gvms4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUANITE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AQUANITE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

