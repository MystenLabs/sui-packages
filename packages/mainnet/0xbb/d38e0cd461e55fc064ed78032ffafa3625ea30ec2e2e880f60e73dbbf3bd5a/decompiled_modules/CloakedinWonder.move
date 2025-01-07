module 0xbbd38e0cd461e55fc064ed78032ffafa3625ea30ec2e2e880f60e73dbbf3bd5a::CloakedinWonder {
    struct CLOAKEDINWONDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOAKEDINWONDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOAKEDINWONDER>(arg0, 0, b"COS", b"Cloaked in Wonder", b"The Aurahma wish you a happy 2022 holiday and new year!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Cloaked_in_Wonder.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLOAKEDINWONDER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOAKEDINWONDER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

