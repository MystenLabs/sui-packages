module 0x8ed1cea4a72daef9a216c1c7adb375aad6accf14facecdbeb98300cbe50aadd::srvc {
    struct SRVC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRVC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRVC>(arg0, 9, b"SRVC", b"SERVICOIN", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SRVC>(&mut v2, 900000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRVC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRVC>>(v1);
    }

    // decompiled from Move bytecode v6
}

