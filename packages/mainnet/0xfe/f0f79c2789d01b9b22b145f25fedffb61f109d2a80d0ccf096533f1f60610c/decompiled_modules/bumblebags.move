module 0xfef0f79c2789d01b9b22b145f25fedffb61f109d2a80d0ccf096533f1f60610c::bumblebags {
    struct BUMBLEBAGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUMBLEBAGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUMBLEBAGS>(arg0, 9, b"BUMBL", b"Bumblebags", b"Stumbling into gains never looked so cute. Bumblebags buzzes around, clueless but always with a bag full of luck.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeid2mevt6oba4aavutlmflmv353oum5htmiotthxovggdhfrtrqmby")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUMBLEBAGS>(&mut v2, 1000000000000000000, @0xae42d2ec4d8ad9708972e523c8aad72bdd89ee7df04afc8a221545ac9577763c, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUMBLEBAGS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUMBLEBAGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

