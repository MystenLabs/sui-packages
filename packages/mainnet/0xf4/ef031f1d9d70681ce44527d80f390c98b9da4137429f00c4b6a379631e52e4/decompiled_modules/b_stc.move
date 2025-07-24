module 0xf4ef031f1d9d70681ce44527d80f390c98b9da4137429f00c4b6a379631e52e4::b_stc {
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

