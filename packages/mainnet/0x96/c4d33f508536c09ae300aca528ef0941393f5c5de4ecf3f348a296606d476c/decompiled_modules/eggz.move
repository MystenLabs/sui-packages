module 0x96c4d33f508536c09ae300aca528ef0941393f5c5de4ecf3f348a296606d476c::eggz {
    struct EGGZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGGZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGGZ>(arg0, 6, b"EGGZ", b"ExitEgg", x"4578697445676720697320746865206d656d65636f696e206f66206472616d617469632065786974732e20437261636b206f6e65207768656e206974e28099732074696d6520746f206261696c2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1757955904628.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EGGZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGGZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

