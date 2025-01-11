module 0x7bef6942fc626caeccf08fb21efb29e3d3ce851fd6f4bd00a7c515b1575604fa::agx {
    struct AGX has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGX>(arg0, 6, b"AGX", b"SUI AgentX", x"456e74657220746865204d61747269782077697468204167656e74582c207468652063727970746f207374617274696e672066726f6d207a65726f20746f20646f6d696e61746520746865206469676974616c207265616c6d2e204265636f6d6520616e204167656e742c20627265616b20667265652066726f6d2063656e7472616c20636f6e74726f6c2c20616e64207365697a65206c696d69746c65737320706f74656e7469616c2e205468652066757475726520697320796f757273e2809477696c6c20796f752074616b6520746865207265642070696c6c3f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736609499452.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

