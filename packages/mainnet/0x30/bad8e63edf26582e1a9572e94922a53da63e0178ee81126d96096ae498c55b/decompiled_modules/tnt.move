module 0x30bad8e63edf26582e1a9572e94922a53da63e0178ee81126d96096ae498c55b::tnt {
    struct TNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TNT>(arg0, 6, b"TNT", b"Turritopsis nutricula", b"The eternal lighthouse jellyfish.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_1_c939d3a62c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TNT>>(v1);
    }

    // decompiled from Move bytecode v6
}

