module 0xabb176a4f53f89bfca99f501016ce19f773a3e6c1be2ab690de80eae247fb2c4::the11 {
    struct THE11 has drop {
        dummy_field: bool,
    }

    fun init(arg0: THE11, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THE11>(arg0, 6, b"THE11", b"The 11", b"Developer by dynamic_11 complex", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiar7sip4zcbtpgxqmw4mcjidqistekaklbnilrps6hthigwexbwga")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THE11>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<THE11>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

