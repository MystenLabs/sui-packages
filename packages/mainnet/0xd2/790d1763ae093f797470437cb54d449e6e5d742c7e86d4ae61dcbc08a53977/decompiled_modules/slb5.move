module 0xd2790d1763ae093f797470437cb54d449e6e5d742c7e86d4ae61dcbc08a53977::slb5 {
    struct SLB5 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SLB5>, arg1: 0x2::coin::Coin<SLB5>) {
        0x2::coin::burn<SLB5>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SLB5>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SLB5>>(0x2::coin::mint<SLB5>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SLB5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLB5>(arg0, 9, b"SLB5", b"SUILab5", b"www.suilab.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.suilab.fun/suilabtoken.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SLB5>>(0x2::coin::mint<SLB5>(&mut v2, 1000000000000000000, arg1), @0x997d28b1b3202d1a7d3a5dc52a4e86401870ee26e08f4dc7a4e3d04ff914f86f);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLB5>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLB5>>(v2, @0x997d28b1b3202d1a7d3a5dc52a4e86401870ee26e08f4dc7a4e3d04ff914f86f);
    }

    // decompiled from Move bytecode v6
}

