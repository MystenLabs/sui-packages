module 0x8350863e4aaac6436c8fd9002c4cff662bf5b58c8364c46583dd94ec32afa1d6::DeliriceesVisitorPass {
    struct DELIRICEESVISITORPASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DELIRICEESVISITORPASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DELIRICEESVISITORPASS>(arg0, 0, b"COS", b"Deliricee's Visitor Pass", b"Visit, stay... but leave you shall not...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Deliricees_Visitor_Pass.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DELIRICEESVISITORPASS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DELIRICEESVISITORPASS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

