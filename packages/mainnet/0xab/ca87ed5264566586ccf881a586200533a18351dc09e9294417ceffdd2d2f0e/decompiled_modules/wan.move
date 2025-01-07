module 0xabca87ed5264566586ccf881a586200533a18351dc09e9294417ceffdd2d2f0e::wan {
    struct WAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAN>(arg0, 9, b"WAN", b"Sui Wan", b"You only need wan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmNPTHDC2H4Am5Fpe2zv19bv6ftwRFkfc2HkJZwrGwqa7i?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WAN>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

