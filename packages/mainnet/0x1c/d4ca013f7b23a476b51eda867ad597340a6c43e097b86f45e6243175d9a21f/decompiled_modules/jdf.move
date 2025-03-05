module 0x1cd4ca013f7b23a476b51eda867ad597340a6c43e097b86f45e6243175d9a21f::jdf {
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

