module 0x9ed6b38411656c1a57eaf3db1875a4144ad0d0a00eced3a04bc792e5090c7ecd::kutyahitler1 {
    struct KUTYAHITLER1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUTYAHITLER1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUTYAHITLER1>(arg0, 6, b"Kutyahitler1", b"test", b"ha elolvasod kutya vagy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/qzt29qc2mehd78y8ooa7ot2odxou_8a63c2bed8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUTYAHITLER1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUTYAHITLER1>>(v1);
    }

    // decompiled from Move bytecode v6
}

