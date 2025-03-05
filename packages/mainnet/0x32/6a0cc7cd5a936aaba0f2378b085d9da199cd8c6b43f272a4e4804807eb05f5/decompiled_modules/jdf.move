module 0x326a0cc7cd5a936aaba0f2378b085d9da199cd8c6b43f272a4e4804807eb05f5::jdf {
    struct JDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: JDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JDF>(arg0, 6, b"JDF", b"dingfeijiacoin", b"The second princess of the Jia family, originally named Jia Dingfei, is chained up as a souvenir!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e_ae_ae_d25dc51ce7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

