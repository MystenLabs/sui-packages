module 0x3da5c69239ec27ec2141b90d04db96b9d23267838647e8e64efa7fd8be8a5346::remus {
    struct REMUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: REMUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REMUS>(arg0, 6, b"REMUS", b"Remus Gargoyle", b"Remus Gargoyle a Black French Bulldog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/REMUS_2e5047ade3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REMUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REMUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

