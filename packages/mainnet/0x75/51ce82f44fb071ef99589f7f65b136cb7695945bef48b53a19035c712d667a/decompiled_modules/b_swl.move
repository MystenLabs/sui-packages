module 0x7551ce82f44fb071ef99589f7f65b136cb7695945bef48b53a19035c712d667a::b_swl {
    struct B_SWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SWL>(arg0, 9, b"bSWL", b"bToken SWL", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SWL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SWL>>(v1);
    }

    // decompiled from Move bytecode v6
}

