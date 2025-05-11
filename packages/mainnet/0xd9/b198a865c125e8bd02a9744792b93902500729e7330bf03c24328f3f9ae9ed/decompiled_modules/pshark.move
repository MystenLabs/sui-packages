module 0xd9b198a865c125e8bd02a9744792b93902500729e7330bf03c24328f3f9ae9ed::pshark {
    struct PSHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSHARK>(arg0, 6, b"PSHARK", b"Pshark", b"Sui pepe Shark identity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000068358_023d375919.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSHARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

