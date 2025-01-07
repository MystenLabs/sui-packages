module 0x512abba707d2a5ad6e2620659f89144dc9ec9e7f77ea4e6fba8fdad40bebcdf5::SingleEpic {
    struct SINGLEEPIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SINGLEEPIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SINGLEEPIC>(arg0, 0, b"PACK", b"Single Epic", b"undefined", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Diving_Petals.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SINGLEEPIC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SINGLEEPIC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

