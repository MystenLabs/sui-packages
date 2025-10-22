module 0x3eed4da0ec42da1b027f1843d079594ea78bef0fd43fabcbf0316a3dbe0e89a4::eusd {
    struct EUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: EUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EUSD>(arg0, 9, b"EUSD", b"Ensofi Reward Token", b"Ensofi Reward Token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EUSD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EUSD>>(v0, @0x7e2cf02c692715cbf3416df4c82360b2aee73fa07674fe87e97aafae0b64b7c2);
    }

    // decompiled from Move bytecode v6
}

