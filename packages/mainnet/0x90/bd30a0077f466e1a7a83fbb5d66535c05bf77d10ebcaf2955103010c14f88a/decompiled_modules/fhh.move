module 0x90bd30a0077f466e1a7a83fbb5d66535c05bf77d10ebcaf2955103010c14f88a::fhh {
    struct FHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FHH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FHH>(arg0, 6, b"FHH", b"FunnyHopHop", b"The Bunny is setting up the stage .... ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/funy_27f451ba4b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FHH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FHH>>(v1);
    }

    // decompiled from Move bytecode v6
}

