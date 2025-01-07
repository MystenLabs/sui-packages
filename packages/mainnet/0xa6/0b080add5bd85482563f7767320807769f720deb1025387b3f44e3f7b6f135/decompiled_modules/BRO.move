module 0xa60b080add5bd85482563f7767320807769f720deb1025387b3f44e3f7b6f135::BRO {
    struct BRO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BRO>, arg1: 0x2::coin::Coin<BRO>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x6718371fd526f62a4ee0a373ca13927409bd05311fb418217c456ffc894c8312, 1);
        0x2::coin::burn<BRO>(arg0, arg1);
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"BRO", b"Crypto BRO's On SUI", b"BRO, Lets Freekin GO!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/png;base64,[PASTE_YOUR_BASE64_IMAGE_HERE]")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: BRO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<BRO>(arg0, arg1);
        0x2::coin::mint_and_transfer<BRO>(&mut v0, 100000000, @0x6718371fd526f62a4ee0a373ca13927409bd05311fb418217c456ffc894c8312, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

