module 0x8b9bd78012ced409f111e227b01c94a30756e9e1b5671e0b96894077195cbdaf::gme {
    struct GME has drop {
        dummy_field: bool,
    }

    fun init(arg0: GME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GME>(arg0, 18, b"GME", b"Arena Wrapped GME", x"313a31204172656e612077726170206f6620526f62696e686f6f6420436861696e20474d452e204c6f636b20524820e28692206d696e743b206275726e20e286922052482072656c656173652e", 0x1::option::none<0x2::url::Url>(), arg1);
        let (v2, v3) = 0x8b9bd78012ced409f111e227b01c94a30756e9e1b5671e0b96894077195cbdaf::bridge::create_vault<GME>(v0, b"GME", arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GME>>(v1);
        0x8b9bd78012ced409f111e227b01c94a30756e9e1b5671e0b96894077195cbdaf::bridge::share_vault<GME>(v2);
        0x2::transfer::public_transfer<0x8b9bd78012ced409f111e227b01c94a30756e9e1b5671e0b96894077195cbdaf::bridge::MinterCap>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

