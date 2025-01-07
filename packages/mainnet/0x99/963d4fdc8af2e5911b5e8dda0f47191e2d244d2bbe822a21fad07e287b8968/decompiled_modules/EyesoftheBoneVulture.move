module 0x99963d4fdc8af2e5911b5e8dda0f47191e2d244d2bbe822a21fad07e287b8968::EyesoftheBoneVulture {
    struct EYESOFTHEBONEVULTURE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EYESOFTHEBONEVULTURE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EYESOFTHEBONEVULTURE>(arg0, 0, b"COS", b"Eyes of the Bone Vulture", b"A gaze not picky... a Lord unmet...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Eyes_Eyes_of_the_Bone_Vulture.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EYESOFTHEBONEVULTURE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EYESOFTHEBONEVULTURE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

