module 0x3e8df03738efeac04fe9d603809e2136c52f0afda3b7f8aef3b02c37ee71bd19::SUI69001 {
    struct SUI69001 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUI69001>, arg1: 0x2::coin::Coin<SUI69001>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<SUI69001>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUI69001>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUI69001>>(0x2::coin::mint<SUI69001>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<SUI69001>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUI69001>>(arg0);
    }

    fun init(arg0: SUI69001, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI69001>(arg0, 9, b"SUI69001", b"SUI 6900", b"CoinDesc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://m.media-amazon.com/images/I/61xa1mU0OYL._AC_UF1000,1000_QL80_.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI69001>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI69001>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

