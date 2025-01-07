module 0xc4eab8ea6d55cab1a63c2fbdc9070b3c6c37253f0ee1b9dfbe8abab344f779c::koban {
    struct KOBAN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KOBAN>, arg1: 0x2::coin::Coin<KOBAN>) {
        0x2::coin::burn<KOBAN>(arg0, arg1);
    }

    fun init(arg0: KOBAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOBAN>(arg0, 9, b"FOBAN", b"Foban", x"f09fa68d20506f7274666f6c696f20746f6b656e2066726f6d204c75636b79204b61742053747564696f732e2046616b652e20f09fa68d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ipfs://QmQrgDz7bW1udxeEEJWmnJufJu4ow2fvdHYqEzzQPcaLmB")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOBAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOBAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KOBAN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KOBAN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

