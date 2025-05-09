module 0xce31341f336bdce2d934e69f014c73bc5ba951247401683bc45146202c80d91d::freak {
    struct FREAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREAK>(arg0, 6, b"FREAK", b"FREAKSUI", x"426f726e206f6e205355492c206275696c7420666f722074686520626f6c642e0a4e6f20726f61646d61702e204e6f2072756c65732e204a75", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic7fsdrgif6km4nvzqlgmf7fs74a2r6d2mbnvded5ppfo5wtfxeom")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FREAK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

