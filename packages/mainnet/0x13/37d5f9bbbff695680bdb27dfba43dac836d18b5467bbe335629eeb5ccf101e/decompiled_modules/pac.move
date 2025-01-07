module 0x1337d5f9bbbff695680bdb27dfba43dac836d18b5467bbe335629eeb5ccf101e::pac {
    struct PAC has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PAC>, arg1: 0x2::coin::Coin<PAC>) {
        0x2::coin::burn<PAC>(arg0, arg1);
    }

    fun init(arg0: PAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAC>(arg0, 9, b"PAC", b"America Pac", b"America Pac", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmc8Nmeup8o1EhDa6XcJkrU4d5N9QkmBPmee9gqLA7PnnP")), arg1);
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

