module 0x8b2e72c5c06785129218b37979a03037293a7939cff04dc7a3a5928b66e16f70::bob {
    struct BOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOB>(arg0, 6, b"BOB", b"SpongeSui", b"SpongeSui - BOB the Sui meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bobsponje_e4f6d82368.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

