module 0x6cf859530fd073e7353463c25d9e01e5fecc274d018b9cdba026a6f88e796baa::bloo {
    struct BLOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOO>(arg0, 9, b"BLOO", x"f09f91a453756920426c6f6f", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLOO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

