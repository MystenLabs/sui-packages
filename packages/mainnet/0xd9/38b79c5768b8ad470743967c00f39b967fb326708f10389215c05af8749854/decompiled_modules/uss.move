module 0xd938b79c5768b8ad470743967c00f39b967fb326708f10389215c05af8749854::uss {
    struct USS has drop {
        dummy_field: bool,
    }

    fun init(arg0: USS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USS>(arg0, 6, b"USS", b"Upside Down Sui", b"Stable meme coin at sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fsml_J_Yo_K_400x400_143352ccce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USS>>(v1);
    }

    // decompiled from Move bytecode v6
}

