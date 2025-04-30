module 0x30e731330eb661d7b7994c1adbb565e703017f40a080117e545c2c3bc9d100dc::ABE {
    struct ABE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABE>(arg0, 6, b"ABE", b"Abe San", b"Trump Kun no tariff war kudasai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmWHFKRZzNzfAipCiFZJyWNgR8Ztstt9ZDxUdkaSeZaZMc")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

