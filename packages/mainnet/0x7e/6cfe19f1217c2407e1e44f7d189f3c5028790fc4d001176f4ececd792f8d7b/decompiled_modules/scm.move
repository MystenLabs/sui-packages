module 0x7e6cfe19f1217c2407e1e44f7d189f3c5028790fc4d001176f4ececd792f8d7b::scm {
    struct SCM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCM>(arg0, 6, b"SCM", b"SadCat Meme", b"just sad cat , bring me love and hug ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/El_Gato_8fd0f56049.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCM>>(v1);
    }

    // decompiled from Move bytecode v6
}

