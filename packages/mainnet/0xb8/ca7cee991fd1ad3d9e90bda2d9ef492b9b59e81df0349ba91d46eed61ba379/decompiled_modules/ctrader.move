module 0xb8ca7cee991fd1ad3d9e90bda2d9ef492b9b59e81df0349ba91d46eed61ba379::ctrader {
    struct CTRADER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTRADER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTRADER>(arg0, 6, b"Ctrader", b"cTrader", b"cTrader is a complete trading platform solution for forex and CFD brokers to offer their traders. The platform is packed with a full range of features to cater to every investment preference.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731457982804.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTRADER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTRADER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

