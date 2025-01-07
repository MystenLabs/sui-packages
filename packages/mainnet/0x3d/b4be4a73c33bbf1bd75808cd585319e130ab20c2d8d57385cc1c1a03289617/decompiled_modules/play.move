module 0x3db4be4a73c33bbf1bd75808cd585319e130ab20c2d8d57385cc1c1a03289617::play {
    struct PLAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLAY>(arg0, 9, b"PLAY", b"PLAY IT", b"PLAY THIS GAME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://png.pngtree.com/png-clipart/20210808/original/pngtree-play-editable-text-effect-png-image_6619863.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PLAY>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLAY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

