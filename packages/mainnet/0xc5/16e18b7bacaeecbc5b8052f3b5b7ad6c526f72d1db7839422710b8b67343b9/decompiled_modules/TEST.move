module 0xc516e18b7bacaeecbc5b8052f3b5b7ad6c526f72d1db7839422710b8b67343b9::TEST {
    struct TEST has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TEST>, arg1: 0x2::coin::Coin<TEST>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<TEST>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TEST>>(0x2::coin::mint<TEST>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<TEST>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TEST>>(arg0);
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 9, b"TEST", x"5975702076616c69646172c3a120717565205b636f696e4e616d655d2028486f6c6929", x"436f6e206573746520746573742061646963696f6e616c2c205975702076616c69646172c3a12071756520636f696e4e616d6520792073796d626f6c206e6f207365616e20696775616c6573202873696e20696d706f72746172206d6179c3ba7363756c61732f6d696ec3ba7363756c6173292e2020c2bf517569657265732071756520656e206361736f2064652066616c6c6f20656c206572726f722073652061736f63696520616c2073796d626f6c206573706563c3ad666963616d656e74652028656e2076657a2064656c20666f726d756c6172696f20656e7465726f293f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.dictionary.com/e/wp-content/uploads/2018/03/asdfmovie-300x300.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

