module 0xcc41ab755b9e4c71a80ecaf216d9cc654e7ec4e60ea4fbb4a48f5d12e558c90b::goop_ml3xezn2jaz6 {
    struct GOOP_ML3XEZN2JAZ6 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOP_ML3XEZN2JAZ6, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOP_ML3XEZN2JAZ6>(arg0, 9, b"GOOP", b"TheBurntPeanut", b"TheBurntPeanut Loves GOOP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmNdBRyS3jTt4gv3x6u6JK8f41wc3qdpdEJJdVwUDvTz3n")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOOP_ML3XEZN2JAZ6>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOP_ML3XEZN2JAZ6>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

