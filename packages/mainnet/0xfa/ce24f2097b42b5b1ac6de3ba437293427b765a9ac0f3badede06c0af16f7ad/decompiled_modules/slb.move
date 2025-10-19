module 0xface24f2097b42b5b1ac6de3ba437293427b765a9ac0f3badede06c0af16f7ad::slb {
    struct SLB has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SLB>, arg1: 0x2::coin::Coin<SLB>) {
        0x2::coin::burn<SLB>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SLB>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SLB>>(0x2::coin::mint<SLB>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SLB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLB>(arg0, 9, b"SLB", b"SUILab", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/icon.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SLB>>(0x2::coin::mint<SLB>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

