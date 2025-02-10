module 0xf720af4ba64ef0e8b838549c59e9c799229b9dabc9a2ad78b6a959ca95eb8f33::chz {
    struct CHZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHZ>(arg0, 9, b"CHZ", b"CherryX", b"Forged in a black hole of adulting, CherryX gives you cosmic permission to eat pizza alone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/dstqcb0lj/image/upload/v1739213563/msgxmbp7e90rdyitunvx.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHZ>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHZ>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

