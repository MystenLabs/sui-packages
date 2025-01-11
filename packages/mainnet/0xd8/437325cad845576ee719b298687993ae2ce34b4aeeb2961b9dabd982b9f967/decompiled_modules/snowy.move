module 0xd8437325cad845576ee719b298687993ae2ce34b4aeeb2961b9dabd982b9f967::snowy {
    struct SNOWY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOWY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOWY>(arg0, 6, b"SNOWY", b"SNOWY on Sui", x"24534e4f57593a205468652052697365206f6620746865205768696d736963616c205768697465204361740a0a4f6e63652075706f6e20612074696d6520696e2061206469676974616c207265616c6d2c206120636861726d696e6720776869746520636174206e616d656420536e6f77792063617074757265642074686520686561727473206f662074686f7573616e64732e20576974682068657220666c756666792066757220616e6420737061726b6c696e6720657965732c2077696c6c2073686520626520746865206e6577207472656e6420696e2074686520776174657220636861696e3f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736586723048.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNOWY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOWY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

