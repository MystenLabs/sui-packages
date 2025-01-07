module 0x28e45e9d437fb3dc8e141f8e3811fc5654d1647f27aa1b4c30ab5b82c2887d9a::mbs {
    struct MBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBS>(arg0, 6, b"MBS", b"Mew Blue", b"Mew meets his unknown brother Mew Blue a powerful Water Mew making waves on sui. Join us as we burn the supply and add utility! Lets build a real community!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5540_003071b2eb.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

