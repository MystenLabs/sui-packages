module 0xf90854386371d46c98a2fc6e7da275f3ca7f8d2ef1a03f47262dc35414e3e3f4::pac {
    struct PAC has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PAC>, arg1: 0x2::coin::Coin<PAC>) {
        0x2::coin::burn<PAC>(arg0, arg1);
    }

    fun init(arg0: PAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAC>(arg0, 9, b"PAC", b"DARK MAGA", b"Make America Great Again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQzLo35YsfZQU9cwXEP6pM7UZjM9qY8ghP4fwoBLf2zZx")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PAC>(&mut v2, 25000000000000000, @0x4a5b9e94271c1a74cda9a91e494d65f7ad0116e9ad1817c4c87f861825ef55bd, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAC>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PAC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PAC>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

