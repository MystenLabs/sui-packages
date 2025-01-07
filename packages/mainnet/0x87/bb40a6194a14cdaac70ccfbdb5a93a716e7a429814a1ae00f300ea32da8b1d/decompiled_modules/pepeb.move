module 0x87bb40a6194a14cdaac70ccfbdb5a93a716e7a429814a1ae00f300ea32da8b1d::pepeb {
    struct PEPEB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEB>(arg0, 9, b"PEPEB", b"PEPE BLUE", b"PepeBlue on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tomato-deep-eel-22.mypinata.cloud/ipfs/QmcFMNTk9Rf6VMHmeVZ6WZzCT94hedh9B7f4arDNDcDjHH")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEPEB>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEB>>(v1);
    }

    // decompiled from Move bytecode v6
}

