module 0x9682206d1e9bf5e809ef34224aa3d682de8bb145d0fb50bb2e3eacd2ec798060::queef {
    struct QUEEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUEEF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUEEF>(arg0, 6, b"Queef", b"Queefcoin", x"536f6c20697320666f722066617274696e67200a53756920697320666f72207175656566696e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigdepttkk36tnchucrhsibxnxdclm2ni2byd2wt7ob4jhiov6tapu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUEEF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<QUEEF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

