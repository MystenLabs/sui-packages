module 0x9a4ba3338384d36033065f9cf0c58078033a718a92f091f12a551f6984c290c5::amc {
    struct AMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMC>(arg0, 9, b"AMC", b"Arena Wrapped AMC", x"313a31204172656e612077726170206f6620526f62696e686f6f6420436861696e20414d432028396470292e204c6f636b20524820e28692206d696e743b206275726e20e286922052482072656c656173652e", 0x1::option::none<0x2::url::Url>(), arg1);
        let (v2, v3) = 0x9a4ba3338384d36033065f9cf0c58078033a718a92f091f12a551f6984c290c5::bridge::create_vault<AMC>(v0, b"AMC", arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMC>>(v1);
        0x9a4ba3338384d36033065f9cf0c58078033a718a92f091f12a551f6984c290c5::bridge::share_vault<AMC>(v2);
        0x2::transfer::public_transfer<0x9a4ba3338384d36033065f9cf0c58078033a718a92f091f12a551f6984c290c5::bridge::MinterCap>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

