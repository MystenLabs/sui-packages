module 0xc49961fe241a39b8a1ae165d9bfb0e60aa3fc53ae8de6267104244c6c9961c21::sakuya {
    struct SAKUYA has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SAKUYA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SAKUYA>>(0x2::coin::mint<SAKUYA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SAKUYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAKUYA>(arg0, 9, b"SAKUYA", b"Shadow Sakura", x"53686520626c6f6f6d73207768657265206f74686572732063616e2774207365652e20536861646f772053616b757261206973207468652065636f73797374656d20746f6b656e206f662053616b7572612045786368616e676520e2809420536861646f77205661756c74732c205374616b65324561726e2c20616e64206d756c7469636861696e20696e6672617374727563747572652e20536f6c616e612066697273742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/ddzkrNwXBzFXGeNMwTaWPx9u5S8u2b03OKxew5Ty3cc")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAKUYA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAKUYA>>(v1);
    }

    // decompiled from Move bytecode v7
}

