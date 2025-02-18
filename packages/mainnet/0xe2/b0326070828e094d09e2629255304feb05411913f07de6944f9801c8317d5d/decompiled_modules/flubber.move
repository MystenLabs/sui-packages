module 0xe2b0326070828e094d09e2629255304feb05411913f07de6944f9801c8317d5d::flubber {
    struct FLUBBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUBBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUBBER>(arg0, 9, b"FLUBBER", b"Flubber", b"Just some jelly", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/kgeMxMW.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FLUBBER>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUBBER>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLUBBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

