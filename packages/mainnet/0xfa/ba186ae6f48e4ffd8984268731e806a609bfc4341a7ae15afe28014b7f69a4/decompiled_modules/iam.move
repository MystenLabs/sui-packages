module 0xfaba186ae6f48e4ffd8984268731e806a609bfc4341a7ae15afe28014b7f69a4::iam {
    struct IAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: IAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IAM>(arg0, 6, b"Iam", b"Ben Jeshua", b"Truly, truly, I say to you, whoever believes has eternal life.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/93a7ace2d73cdbeb1aebca78b05e43fc_100448941d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

