module 0x5d7995ddd86d3e57961249d23c447213fbc1938e6e7cdcdd9e0c77b0dccdcd50::dolphin {
    struct DOLPHIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLPHIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLPHIN>(arg0, 9, b"DOLPHIN", b"Dolphin on SUI", x"446f70696e2074686520446f6c7068696e20f09f90ac202d2074686520646f70656420636f6d6d756e69747920636f696e206d616b696e67207761766573206f6e20537569204e6574776f726b2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/sui/0xcb796b97c03d816b39eef6b98d7abcebf2e16ae4f92e7a9d5a371205dadaf8c2::dopin::dopin.png?size=lg&key=6493c5")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOLPHIN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLPHIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLPHIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

