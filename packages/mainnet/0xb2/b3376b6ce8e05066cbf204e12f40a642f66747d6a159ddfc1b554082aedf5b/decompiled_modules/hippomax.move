module 0xb2b3376b6ce8e05066cbf204e12f40a642f66747d6a159ddfc1b554082aedf5b::hippomax {
    struct HIPPOMAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPOMAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPOMAX>(arg0, 9, b"HIPPOMAX", b"HIPPO MAX", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmT9aFOqkXtwftwss8840JyUdmh063zxfASw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HIPPOMAX>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPOMAX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPPOMAX>>(v1);
    }

    // decompiled from Move bytecode v6
}

