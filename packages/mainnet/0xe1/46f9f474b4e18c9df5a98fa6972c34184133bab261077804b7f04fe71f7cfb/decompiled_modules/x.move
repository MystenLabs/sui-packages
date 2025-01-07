module 0xe146f9f474b4e18c9df5a98fa6972c34184133bab261077804b7f04fe71f7cfb::x {
    struct X has drop {
        dummy_field: bool,
    }

    fun init(arg0: X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<X>(arg0, 9, b"X", b"Legacy Media Killer", x"f09d958f20697320746865204c6567616379204d65646961204b696c6c65722e20467265652053706565636820506c6174666f726d202d20506f77657220746f207468652070656f706c6521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://node1.irys.xyz/P5WyON0I7WRvxEZaRWYJtEf3m6fQiUujcxMHvNo3RWc"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<X>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<X>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<X>>(v2);
    }

    // decompiled from Move bytecode v6
}

