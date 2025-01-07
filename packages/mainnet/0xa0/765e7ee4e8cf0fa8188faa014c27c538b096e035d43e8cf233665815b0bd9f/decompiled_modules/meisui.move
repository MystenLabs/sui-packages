module 0xa0765e7ee4e8cf0fa8188faa014c27c538b096e035d43e8cf233665815b0bd9f::meisui {
    struct MEISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEISUI>(arg0, 6, b"MeiSui", x"4d656953756920e6b2a1e6b0b4", x"4d6569205375693a204e6f205355492c206e6f20776f7272696573e280946a7573742073636172636974792c20736d696c65732c20616e64206472792068756d6f722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731193913173.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEISUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEISUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

