module 0x4d4a52e8e89119c16f286e8cea67613f9d5fcfec291be60549f4ae507c10deb5::bvb {
    struct BVB has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BVB>, arg1: 0x2::coin::Coin<BVB>) {
        0x2::coin::burn<BVB>(arg0, arg1);
    }

    public entry fun custom_burn(arg0: &mut 0x2::coin::TreasuryCap<BVB>, arg1: &mut 0x2::coin::Coin<BVB>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<BVB>(arg0, 0x2::coin::split<BVB>(arg1, arg2, arg3));
    }

    fun init(arg0: BVB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BVB>(arg0, 6, b"BVB", b"BVB", b"Borussia Dortmund Fan Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://upload.wikimedia.org/wikipedia/commons/thumb/6/67/Borussia_Dortmund_logo.svg/1200px-Borussia_Dortmund_logo.svg.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BVB>(&mut v2, 500000000000000000, @0xffed1e3a3b44c55d8a1300bf9ad7abb11825d45e66ab4bcadb5f7b5f4bce7d3a, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BVB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BVB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

