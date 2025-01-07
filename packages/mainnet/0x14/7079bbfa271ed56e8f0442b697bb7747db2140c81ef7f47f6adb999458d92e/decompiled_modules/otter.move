module 0x147079bbfa271ed56e8f0442b697bb7747db2140c81ef7f47f6adb999458d92e::otter {
    struct OTTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTTER>(arg0, 2, b"OTTER", b"OTTER", b"OTTER ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/2kr3TIL.jpeg")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 100000000000000, v4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OTTER>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<OTTER>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<OTTER>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<OTTER>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

