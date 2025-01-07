module 0x2aa24a29cafdce6477f7dfce2545893b333c9e84e804f800beb366fe4d300b9d::suirl {
    struct SUIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRL>(arg0, 6, b"SUIRL", b"Sui Drawn Realities", b"Welcome to SUIRL, where creativity meets community on the Sui network! SUIRL is a unique meme token that invites artists and meme lovers alike to bring their imaginations to life through hand-drawn art. With a focus on fostering creativity, SUIRL encourages participants to sketch, doodle, and create whimsical drawings inspired by our vibrant community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2_8f2fa723fc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

