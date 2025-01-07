module 0x8fe93572a501db0becf1937a64c1f9eb09a96a779eb4d857913ba413c6c25bce::plankton {
    struct PLANKTON has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLANKTON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLANKTON>(arg0, 9, b"PLANKTON", b"Plankton", b"Plankton Meme from Sui Chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1844421991320911876/2LYcCmUv.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PLANKTON>(&mut v2, 445000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLANKTON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLANKTON>>(v1);
    }

    // decompiled from Move bytecode v6
}

