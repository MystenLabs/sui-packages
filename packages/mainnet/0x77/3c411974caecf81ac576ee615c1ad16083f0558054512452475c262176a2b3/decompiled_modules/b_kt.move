module 0x773c411974caecf81ac576ee615c1ad16083f0558054512452475c262176a2b3::b_kt {
    struct B_KT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_KT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_KT>(arg0, 9, b"bKT", b"bToken KT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_KT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_KT>>(v1);
    }

    // decompiled from Move bytecode v6
}

