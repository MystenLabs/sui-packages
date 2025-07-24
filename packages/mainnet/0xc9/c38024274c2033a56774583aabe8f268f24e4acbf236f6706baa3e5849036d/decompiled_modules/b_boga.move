module 0xc9c38024274c2033a56774583aabe8f268f24e4acbf236f6706baa3e5849036d::b_boga {
    struct B_BOGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BOGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BOGA>(arg0, 9, b"bBOGA", b"bToken BOGA", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BOGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BOGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

