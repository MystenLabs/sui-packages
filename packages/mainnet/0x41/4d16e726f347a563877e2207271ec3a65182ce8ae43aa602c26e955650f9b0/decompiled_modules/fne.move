module 0x414d16e726f347a563877e2207271ec3a65182ce8ae43aa602c26e955650f9b0::fne {
    struct FNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FNE>(arg0, 9, b"FNE", b"FINE", b"This is Fine", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ibb.co/ZL96Z6H")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FNE>(&mut v2, 15000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FNE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

