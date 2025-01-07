module 0xdae7fe0578ead3813fcdea288978d6e86511f4ec4996b6b8fcb054a6f3f34fa6::wha {
    struct WHA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WHA>, arg1: 0x2::coin::Coin<WHA>) {
        0x2::coin::burn<WHA>(arg0, arg1);
    }

    fun init(arg0: WHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHA>(arg0, 5, b"TEST", b"TEST", b"TEST token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        mint(v3, 10000000000000000000, @0x5002247a747ccf9ca743726a9a768247e3ebea204e247f23a3b4c6f212db30d0, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHA>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WHA>>(v2);
    }

    fun mint(arg0: &mut 0x2::coin::TreasuryCap<WHA>, arg1: u128, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WHA>(arg0, (arg1 as u64), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

