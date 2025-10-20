module 0x7b052915dda9c520555929983f5d8101ea8634609954f9772175a9ce4a5557d2::slb4 {
    struct SLB4 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SLB4>, arg1: 0x2::coin::Coin<SLB4>) {
        0x2::coin::burn<SLB4>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SLB4>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SLB4>>(0x2::coin::mint<SLB4>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SLB4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLB4>(arg0, 9, b"SLB4", b"SUILab4", b"No description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.suilab.fun/suilabtoken.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SLB4>>(0x2::coin::mint<SLB4>(&mut v2, 1000000000000000000, arg1), @0x997d28b1b3202d1a7d3a5dc52a4e86401870ee26e08f4dc7a4e3d04ff914f86f);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLB4>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLB4>>(v2, @0x997d28b1b3202d1a7d3a5dc52a4e86401870ee26e08f4dc7a4e3d04ff914f86f);
    }

    // decompiled from Move bytecode v6
}

