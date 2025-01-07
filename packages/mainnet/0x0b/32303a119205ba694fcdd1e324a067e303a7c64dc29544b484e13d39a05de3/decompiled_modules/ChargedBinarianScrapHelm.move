module 0xb32303a119205ba694fcdd1e324a067e303a7c64dc29544b484e13d39a05de3::ChargedBinarianScrapHelm {
    struct CHARGEDBINARIANSCRAPHELM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHARGEDBINARIANSCRAPHELM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHARGEDBINARIANSCRAPHELM>(arg0, 0, b"COS", b"Charged Binarian Scrap Helm", b"Young one, beware-lest you tamper with that which you cannot understand.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Charged_Binarian_Scrap_Helm.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHARGEDBINARIANSCRAPHELM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARGEDBINARIANSCRAPHELM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

