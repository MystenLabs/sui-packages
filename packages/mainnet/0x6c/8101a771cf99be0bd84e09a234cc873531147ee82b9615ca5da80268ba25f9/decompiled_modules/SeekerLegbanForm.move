module 0x6c8101a771cf99be0bd84e09a234cc873531147ee82b9615ca5da80268ba25f9::SeekerLegbanForm {
    struct SEEKERLEGBANFORM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEEKERLEGBANFORM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEEKERLEGBANFORM>(arg0, 0, b"COS", b"Seeker Legban Form", b"Be not of this place... be of the Elsewhere...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Body_Seeker_Legban_Form.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEEKERLEGBANFORM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEEKERLEGBANFORM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

