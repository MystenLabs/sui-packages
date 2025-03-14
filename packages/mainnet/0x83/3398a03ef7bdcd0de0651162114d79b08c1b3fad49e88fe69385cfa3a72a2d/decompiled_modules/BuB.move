module 0x833398a03ef7bdcd0de0651162114d79b08c1b3fad49e88fe69385cfa3a72a2d::BuB {
    struct BUB has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BUB>, arg1: 0x2::coin::Coin<BUB>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x817a226a16588cedbe265d98bf1c3df0a31e59eaa082419a85be43e575783ad4, 1001);
        0x2::coin::burn<BUB>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BUB>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x817a226a16588cedbe265d98bf1c3df0a31e59eaa082419a85be43e575783ad4, 1001);
        assert!(0x2::coin::total_supply<BUB>(arg0) + arg1 <= 100000000000000000, 1002);
        0x2::transfer::public_transfer<0x2::coin::Coin<BUB>>(0x2::coin::mint<BUB>(arg0, arg1, arg2), @0x817a226a16588cedbe265d98bf1c3df0a31e59eaa082419a85be43e575783ad4);
    }

    public entry fun split(arg0: &mut 0x2::coin::Coin<BUB>, arg1: vector<u64>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x817a226a16588cedbe265d98bf1c3df0a31e59eaa082419a85be43e575783ad4, 1001);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<BUB>>(0x2::coin::split<BUB>(arg0, *0x1::vector::borrow<u64>(&arg1, v0), arg2), @0x817a226a16588cedbe265d98bf1c3df0a31e59eaa082419a85be43e575783ad4);
            v0 = v0 + 1;
        };
    }

    public fun get_max_supply() : u64 {
        100000000000000000
    }

    fun init(arg0: BUB, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0x817a226a16588cedbe265d98bf1c3df0a31e59eaa082419a85be43e575783ad4, 1001);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUB>>(initialize_currency(arg0, arg1), @0x817a226a16588cedbe265d98bf1c3df0a31e59eaa082419a85be43e575783ad4);
    }

    fun initialize_currency(arg0: BUB, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<BUB> {
        let (v0, v1) = 0x2::coin::create_currency<BUB>(arg0, 9, b"BuB", x"e292b7e2938ae292b7e29aaa206f6e20535549f09f92a7", x"e292b7e2938ae292b720697320616e20756e646572776174657220657870657269656e6365206f6e2053554920426c6f636b636861696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/png;base64,IMAGE")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BUB>>(0x2::coin::mint<BUB>(&mut v2, 100000000000000000, arg1), @0x817a226a16588cedbe265d98bf1c3df0a31e59eaa082419a85be43e575783ad4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUB>>(v1);
        v2
    }

    // decompiled from Move bytecode v6
}

