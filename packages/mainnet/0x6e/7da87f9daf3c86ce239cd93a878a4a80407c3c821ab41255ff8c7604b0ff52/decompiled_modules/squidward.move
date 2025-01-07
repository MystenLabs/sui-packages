module 0x6e7da87f9daf3c86ce239cd93a878a4a80407c3c821ab41255ff8c7604b0ff52::squidward {
    struct SQUIDWARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIDWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIDWARD>(arg0, 6, b"SQUIDWARD", b"SQUIDWARD ON SUI", b"Welcome to Bikini bottom, But with more gains and less SpongeBob. Finally, something he cant ruin! #NoSpatulasAllowed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/Untitled_Artwork_92_6289bbcb16.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIDWARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIDWARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

