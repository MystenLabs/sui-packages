module 0xe99a396837a51221b4c418fb15b9d99445f2934383c77328f67dd5b7fa4d7457::b_uncbot {
    struct B_UNCBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_UNCBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_UNCBOT>(arg0, 9, b"bUNCBOT", b"bToken UNCBOT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_UNCBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_UNCBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

