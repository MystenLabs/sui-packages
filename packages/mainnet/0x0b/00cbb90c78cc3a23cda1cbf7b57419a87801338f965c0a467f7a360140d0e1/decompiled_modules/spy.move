module 0xb00cbb90c78cc3a23cda1cbf7b57419a87801338f965c0a467f7a360140d0e1::spy {
    struct SPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPY>(arg0, 6, b"Spy", b"Suipremacy", b"Believe in the suipremacy of Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000675607_0c344c7e30.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

