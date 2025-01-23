module 0x9066d24ce54e1e6c640063d8088d8ad93f508a7e2100f648adca131310b01867::vine16z {
    struct VINE16Z has drop {
        dummy_field: bool,
    }

    fun init(arg0: VINE16Z, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VINE16Z>(arg0, 9, b"vine16z", b"vine16z on sui", b"do it for the vine", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmfDRy2XngBnVVCtSZkqZyPMkDfgwQvVi4FaHSNR3PxS3u")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VINE16Z>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VINE16Z>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VINE16Z>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

