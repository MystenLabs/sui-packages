module 0x823dee72fb41c49119843c688b54c7f00878bd352a8d289b9073be348c49ce2::b_ege {
    struct B_EGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_EGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_EGE>(arg0, 9, b"bEGE", b"bToken EGE", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_EGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_EGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

