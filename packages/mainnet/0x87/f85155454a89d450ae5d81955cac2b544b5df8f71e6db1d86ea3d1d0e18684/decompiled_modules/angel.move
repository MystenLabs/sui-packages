module 0x87f85155454a89d450ae5d81955cac2b544b5df8f71e6db1d86ea3d1d0e18684::angel {
    struct ANGEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANGEL>(arg0, 6, b"ANGEL", b"ANGEL DOG", b"DOG OF ARMSTRONG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AN_656d3781db.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANGEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANGEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

