module 0x23755534f15b1d53e22a4b750780dc2dfaa8810efa3bd3ac72fdbb68ecdb0411::ssm {
    struct SSM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSM>(arg0, 6, b"SSM", b"SquideSuiMeme", b"Squide The Pearl OF SUI, The cryptocurrency market on the SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SQUIDE_6e86908141.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSM>>(v1);
    }

    // decompiled from Move bytecode v6
}

