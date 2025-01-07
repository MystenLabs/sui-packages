module 0xc59493159eeb2adbc1c37abd60c0f42904e2a8f8197a60ad12e5ef1599dc6a28::lini {
    struct LINI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LINI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LINI>(arg0, 6, b"LINI", b"Turtlellini", b"$LINI token enbraces a community of curious and enthusiastic turtles. They love hanging-out, doing sports, eating, travelling, music, and more things!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZE_78_Jx_WEAA_Vpi_B_0264680958.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LINI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LINI>>(v1);
    }

    // decompiled from Move bytecode v6
}

