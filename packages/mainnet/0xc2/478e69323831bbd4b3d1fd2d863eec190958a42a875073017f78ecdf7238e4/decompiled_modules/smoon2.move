module 0xc2478e69323831bbd4b3d1fd2d863eec190958a42a875073017f78ecdf7238e4::smoon2 {
    struct SMOON2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOON2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOON2>(arg0, 6, b"SMOON2", b"SMOON", b"let's make sui become the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreico42kftwx6e5gzksokjohphna3q2sqsi5mv5mmzgan43oiyz3sle")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOON2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SMOON2>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

