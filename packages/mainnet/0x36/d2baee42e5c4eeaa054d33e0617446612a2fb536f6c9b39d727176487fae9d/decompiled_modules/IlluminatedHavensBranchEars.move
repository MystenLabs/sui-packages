module 0x36d2baee42e5c4eeaa054d33e0617446612a2fb536f6c9b39d727176487fae9d::IlluminatedHavensBranchEars {
    struct ILLUMINATEDHAVENSBRANCHEARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ILLUMINATEDHAVENSBRANCHEARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ILLUMINATEDHAVENSBRANCHEARS>(arg0, 0, b"COS", b"Illuminated Havens Branch-Ears", b"Sought... found... tell me, wise one, for whom do you reach?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Illuminated_Havens_Branch-Ears.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ILLUMINATEDHAVENSBRANCHEARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ILLUMINATEDHAVENSBRANCHEARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

