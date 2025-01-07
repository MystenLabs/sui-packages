module 0x1f4db84887cf504682920380981d8024fd4867b5d5b2f1e6b692ac1b26bdac72::fid {
    struct FID has drop {
        dummy_field: bool,
    }

    fun init(arg0: FID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FID>(arg0, 7, b"fid", b"fideo", b"tuco", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FID>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FID>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FID>>(v1);
    }

    // decompiled from Move bytecode v6
}

