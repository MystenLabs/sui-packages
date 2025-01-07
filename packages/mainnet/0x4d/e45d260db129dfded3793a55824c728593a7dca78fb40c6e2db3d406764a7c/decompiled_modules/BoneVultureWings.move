module 0x4de45d260db129dfded3793a55824c728593a7dca78fb40c6e2db3d406764a7c::BoneVultureWings {
    struct BONEVULTUREWINGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONEVULTUREWINGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONEVULTUREWINGS>(arg0, 0, b"COS", b"Bone Vulture Wings", b"A scream... a squawk... torn between something and nothing...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Bone_Vulture_Wings.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BONEVULTUREWINGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONEVULTUREWINGS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

