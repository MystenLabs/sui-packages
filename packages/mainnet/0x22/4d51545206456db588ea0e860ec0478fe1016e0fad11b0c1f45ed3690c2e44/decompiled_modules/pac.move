module 0x224d51545206456db588ea0e860ec0478fe1016e0fad11b0c1f45ed3690c2e44::pac {
    struct PAC has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PAC>, arg1: 0x2::coin::Coin<PAC>) {
        0x2::coin::burn<PAC>(arg0, arg1);
    }

    fun init(arg0: PAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAC>(arg0, 9, b"PAC", b"DARK MAGA", b"Make America Great Again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQzLo35YsfZQU9cwXEP6pM7UZjM9qY8ghP4fwoBLf2zZx")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PAC>(&mut v2, 25000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAC>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PAC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PAC>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

