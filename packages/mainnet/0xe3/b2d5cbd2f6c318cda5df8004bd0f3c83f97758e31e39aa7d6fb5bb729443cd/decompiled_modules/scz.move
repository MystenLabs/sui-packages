module 0xe3b2d5cbd2f6c318cda5df8004bd0f3c83f97758e31e39aa7d6fb5bb729443cd::scz {
    struct SCZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCZ>(arg0, 6, b"SCZ", b"Sendoor cz", b"If you can't hold , you won't be rich. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000036523_1d3d172381.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

