module 0xc67ddeb64d2cf95b03bd710e5353c2f9ed10843d4b4b1b187b49b8585362fdee::sct {
    struct SCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCT>(arg0, 6, b"SCT", b"Suspect Cat", b"Your Honor, I object!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6191_223b28b23b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

