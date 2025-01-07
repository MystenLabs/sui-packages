module 0x8504a5a239fdab2ba47b1c5a9c0c2b063c24faa641de171b8f01673f0f6948cd::h {
    struct H has drop {
        dummy_field: bool,
    }

    fun init(arg0: H, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<H>(arg0, 4, b"H", b"huu", b"fuck off", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.deepai.org/job-view-file/ff387c71-6302-4caa-824e-c39a0e8c6fc4/outputs/output.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<H>(&mut v2, 10001110001110000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<H>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<H>>(v1);
    }

    // decompiled from Move bytecode v6
}

