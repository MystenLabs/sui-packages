module 0xae27813fb9a754e68bf65cc86f4b7c6bb64b2613a8918d918cc13a08939f45b5::drsui {
    struct DRSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRSUI>(arg0, 6, b"DRSUI", b"Suintologyst", x"44722e53756920697320726561647920666f72206e65772070617469656e74732c206a6f696e206869732054656c656772616d20616e642068697320617373697374616e7420436c616972652077696c6c206d616b6520796f7520616e64206170706f696e746d656e74210a4f70656e20686f7572733a0a39504d2d39414d20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_91a97e8635.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

