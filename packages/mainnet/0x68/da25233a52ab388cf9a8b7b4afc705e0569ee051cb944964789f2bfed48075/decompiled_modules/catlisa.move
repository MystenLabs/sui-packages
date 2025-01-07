module 0x68da25233a52ab388cf9a8b7b4afc705e0569ee051cb944964789f2bfed48075::catlisa {
    struct CATLISA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATLISA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATLISA>(arg0, 9, b"CATLISA", b"Catlisa", b"Imagine Mona Lisa as a Cat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1727971638378-ca62feb6b25a7c777a493f7ec5f64fcf.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CATLISA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATLISA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATLISA>>(v1);
    }

    // decompiled from Move bytecode v6
}

