module 0xce587ad6c237f16c3beaeadf1a8e44a671370ddf364a933a523fdd1a18d1cf59::sen {
    struct SEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEN>(arg0, 6, b"Sen", b"SenSui", x"4d61737465722074686520626c6f636b636861696e2077697468202353656e5375692c20696e7370697265642062792053656e736569200a506f7765726564206279205375694e6574776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t09t_IE_5_Q_400x400_c9d278b028.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

