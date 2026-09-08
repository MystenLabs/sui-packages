module 0xf01d0b041f98c02a29c8d1efffd03d60db42b3a20f5899ff5e0f663f0ea09db::tsla {
    struct TSLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSLA>(arg0, 18, b"TSLA", b"Arena Wrapped TSLA", x"313a31204172656e612077726170206f6620526f62696e686f6f6420436861696e2054534c412e204c6f636b20524820e28692206d696e743b206275726e20e286922052482072656c656173652e", 0x1::option::none<0x2::url::Url>(), arg1);
        let (v2, v3) = 0xf01d0b041f98c02a29c8d1efffd03d60db42b3a20f5899ff5e0f663f0ea09db::bridge::create_vault<TSLA>(v0, b"TSLA", arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TSLA>>(v1);
        0xf01d0b041f98c02a29c8d1efffd03d60db42b3a20f5899ff5e0f663f0ea09db::bridge::share_vault<TSLA>(v2);
        0x2::transfer::public_transfer<0xf01d0b041f98c02a29c8d1efffd03d60db42b3a20f5899ff5e0f663f0ea09db::bridge::MinterCap>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

