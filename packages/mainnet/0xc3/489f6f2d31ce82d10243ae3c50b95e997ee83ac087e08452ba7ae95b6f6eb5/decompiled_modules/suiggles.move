module 0xc3489f6f2d31ce82d10243ae3c50b95e997ee83ac087e08452ba7ae95b6f6eb5::suiggles {
    struct SUIGGLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGGLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGGLES>(arg0, 9, b"SUIGGLES", b"Mister Suiggles", b"The Sui cat Mascot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://framerusercontent.com/images/Q1ik3dKCt582kKAAa032Uy4JyDM.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIGGLES>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGGLES>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGGLES>>(v1);
    }

    // decompiled from Move bytecode v6
}

