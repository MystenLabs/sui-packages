module 0x662d931a97ac7261daa41a46a664e24221f086b8d22d92b9027d2a5e2cf5e668::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT>(arg0, 6, b"CAT", b"Suiyan Cat", b"Suiyan Cat is a playful, water-space flying creature with a Sui Pop-Tart torso, inspired by the iconic Nyan Cat. It zooms through a surreal blend of underwater and cosmic landscapes, leaving a vibrant, y comeme las dos pelotas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cat_75e754fd3e_c254986af7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

