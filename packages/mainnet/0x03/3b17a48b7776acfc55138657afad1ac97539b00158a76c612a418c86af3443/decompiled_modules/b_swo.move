module 0x33b17a48b7776acfc55138657afad1ac97539b00158a76c612a418c86af3443::b_swo {
    struct B_SWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SWO>(arg0, 9, b"bSWO", b"bToken SWO", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SWO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SWO>>(v1);
    }

    // decompiled from Move bytecode v6
}

