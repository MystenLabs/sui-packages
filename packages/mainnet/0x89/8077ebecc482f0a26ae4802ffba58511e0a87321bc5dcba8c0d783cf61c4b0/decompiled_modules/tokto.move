module 0x898077ebecc482f0a26ae4802ffba58511e0a87321bc5dcba8c0d783cf61c4b0::tokto {
    struct TOKTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKTO>(arg0, 6, b"TOKTO", b"TOKENTO", b"Tokentototo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia6txsamfaa365wbqmbvpmgtp2gjyjsqtvlaful55pxisfdtwdmei")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOKTO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

