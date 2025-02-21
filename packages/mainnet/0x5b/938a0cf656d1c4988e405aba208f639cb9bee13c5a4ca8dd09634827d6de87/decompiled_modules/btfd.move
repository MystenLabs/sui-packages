module 0x5b938a0cf656d1c4988e405aba208f639cb9bee13c5a4ca8dd09634827d6de87::btfd {
    struct BTFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTFD>(arg0, 11, b"BTFD", b"BTFD", b"Buy The Fucking Dip", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.btfd.io/_astro/cow-circle.S5_Ojsw4_Z2a0x7O.svg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BTFD>(&mut v2, 17000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTFD>>(v2, @0x356711e610f3fd2adb015e76df4d936d3e3cdf9b35ba57d966b357ce8ec73488);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

