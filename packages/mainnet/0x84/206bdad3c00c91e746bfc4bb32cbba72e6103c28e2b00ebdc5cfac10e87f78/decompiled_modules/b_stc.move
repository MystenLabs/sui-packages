module 0x84206bdad3c00c91e746bfc4bb32cbba72e6103c28e2b00ebdc5cfac10e87f78::b_stc {
    struct B_STC has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_STC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_STC>(arg0, 9, b"bSTC", b"bToken STC", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_STC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_STC>>(v1);
    }

    // decompiled from Move bytecode v6
}

