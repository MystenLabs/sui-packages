module 0xe1e0caf9113bdbe833b9b0e5d9b07ce69806c5725e2bc049b5f08b9c990c5ee8::nani {
    struct NANI has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<NANI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NANI>>(0x2::coin::mint<NANI>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: NANI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NANI>(arg0, 9, b"NANI", b"NANI", b"A cat named NANI with glasses", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1564714594144292865/9Bc4jyxh_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NANI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NANI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NANI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

