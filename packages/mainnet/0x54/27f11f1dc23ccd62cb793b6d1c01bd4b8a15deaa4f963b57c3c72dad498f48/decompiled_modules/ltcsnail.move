module 0x5427f11f1dc23ccd62cb793b6d1c01bd4b8a15deaa4f963b57c3c72dad498f48::ltcsnail {
    struct LTCSNAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LTCSNAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LTCSNAIL>(arg0, 6, b"LTCSNAIL", b"lettuce snail", x"746865206f6e6c79206c65747475636520736e61696c206f6e2074686520536f6c616e610a6e6574776f726b207468617420646f6573206e6f7420636f6e7461696e0a70657374696369646573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_Tela_2024_10_16_a_I_s_18_42_28_88fc5165c6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LTCSNAIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LTCSNAIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

