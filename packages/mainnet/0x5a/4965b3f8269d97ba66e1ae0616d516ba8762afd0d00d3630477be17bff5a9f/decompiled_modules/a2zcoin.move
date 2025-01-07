module 0x5a4965b3f8269d97ba66e1ae0616d516ba8762afd0d00d3630477be17bff5a9f::a2zcoin {
    struct A2ZCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: A2ZCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A2ZCOIN>(arg0, 9, b"A2ZCOIN", b"A2ZCOIN ", b"BINANCE LAB LAUNCHPOOL PROJECT ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ea4f27bc-183e-4505-b9f3-aef42147481d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A2ZCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A2ZCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

