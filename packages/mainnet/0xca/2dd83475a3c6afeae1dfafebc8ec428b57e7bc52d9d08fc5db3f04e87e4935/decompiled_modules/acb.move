module 0xca2dd83475a3c6afeae1dfafebc8ec428b57e7bc52d9d08fc5db3f04e87e4935::acb {
    struct ACB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACB>(arg0, 6, b"ACB", b"ABC", b"ABC!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_0TBFFDGMKvmE0JZ6g2NId14i55VhLAfIew&s"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACB>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ACB>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACB>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

