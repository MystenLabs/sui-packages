module 0x4f64a799a6e3bf90af47829ca51b280f63e7f04689f346e00715f87370486f12::xFrog {
    struct XFROG has drop {
        dummy_field: bool,
    }

    public entry fun burn_mint_cap(arg0: 0x2::coin::TreasuryCap<XFROG>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XFROG>>(arg0, @0x0);
    }

    fun init(arg0: XFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XFROG>(arg0, 3, b"XFG", b"xFrog", b"xFrog - Unleash the Legendary MEMECOIN on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://xfrog.xyz/xfrog192.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XFROG>>(v1);
        0x2::coin::mint_and_transfer<XFROG>(&mut v2, 99000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XFROG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

