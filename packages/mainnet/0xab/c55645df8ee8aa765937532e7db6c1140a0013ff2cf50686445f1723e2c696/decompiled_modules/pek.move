module 0xabc55645df8ee8aa765937532e7db6c1140a0013ff2cf50686445f1723e2c696::pek {
    struct PEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEK>(arg0, 7, b"PEK", b"Sui Pek", b"PEK PEK PEK PEK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmWz61spXF7LTNrjKpdUUJatCkA2mQFCSLwCx8ffWaMZgg?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEK>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

