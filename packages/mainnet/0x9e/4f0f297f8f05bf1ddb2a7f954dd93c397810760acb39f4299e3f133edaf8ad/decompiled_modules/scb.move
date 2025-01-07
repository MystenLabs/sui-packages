module 0x9e4f0f297f8f05bf1ddb2a7f954dd93c397810760acb39f4299e3f133edaf8ad::scb {
    struct SCB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCB>(arg0, 5, b"SCB", b"Sacabam", b"The best meme token that Sui has ever seen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ipfs://bafkreigdxf7biamfqdifni73ca7twmaakkkgylo47ovekl4qjmduu3qaxi")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SCB>(&mut v2, 4700000000000000000, @0xacbe9acf52a945e495420fd24dcdf0b8fe8991d52a1a2189309d770c90347e2c, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCB>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SCB>>(v2);
    }

    // decompiled from Move bytecode v6
}

