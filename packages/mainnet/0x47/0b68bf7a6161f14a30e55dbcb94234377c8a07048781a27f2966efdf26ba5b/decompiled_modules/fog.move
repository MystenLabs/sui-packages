module 0x470b68bf7a6161f14a30e55dbcb94234377c8a07048781a27f2966efdf26ba5b::fog {
    struct FOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOG>(arg0, 6, b"FOG", b"FROG AND A DOG", b"I just want your money... trust me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_11_19_124524831_4d8987eac3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

