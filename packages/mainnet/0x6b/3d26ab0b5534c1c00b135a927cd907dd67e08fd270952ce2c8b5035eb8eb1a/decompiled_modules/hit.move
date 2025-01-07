module 0x6b3d26ab0b5534c1c00b135a927cd907dd67e08fd270952ce2c8b5035eb8eb1a::hit {
    struct HIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIT>(arg0, 9, b"HIT", b"HIT", b"HITCOIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMFQ-QMjSoRCL2GVf2qgGa1SQyDT2VAv5QBg&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HIT>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

