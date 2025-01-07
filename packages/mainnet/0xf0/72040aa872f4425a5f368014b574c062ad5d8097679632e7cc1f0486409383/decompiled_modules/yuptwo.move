module 0xf072040aa872f4425a5f368014b574c062ad5d8097679632e7cc1f0486409383::yuptwo {
    struct YUPTWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUPTWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUPTWO>(arg0, 9, b"YUPTWO", b"yuptwo", b"It's yuppingtwo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://drive.google.com/uc?export=download&id=1BYKs8ZFNX_R9A5axvqfoUr1g8Wi1C6p5")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YUPTWO>(&mut v2, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUPTWO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUPTWO>>(v1);
    }

    // decompiled from Move bytecode v6
}

