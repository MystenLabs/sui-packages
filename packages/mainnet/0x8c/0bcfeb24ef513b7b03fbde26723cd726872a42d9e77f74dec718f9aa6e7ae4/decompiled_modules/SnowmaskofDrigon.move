module 0x8c0bcfeb24ef513b7b03fbde26723cd726872a42d9e77f74dec718f9aa6e7ae4::SnowmaskofDrigon {
    struct SNOWMASKOFDRIGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOWMASKOFDRIGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOWMASKOFDRIGON>(arg0, 0, b"COS", b"Snowmask of Drigon", b"See through it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Eyes_Snowmask_of_Drigon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNOWMASKOFDRIGON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOWMASKOFDRIGON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

