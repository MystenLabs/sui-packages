module 0xb31beb8a12c3814cc402ae5eb9ab9405b5633942644b8aaa7c069f00d7cd9ec2::sSUI {
    struct SSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSUI>(arg0, 9, b"sysSUI", b"SY sSUI", b"SY scallop sSUI", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

