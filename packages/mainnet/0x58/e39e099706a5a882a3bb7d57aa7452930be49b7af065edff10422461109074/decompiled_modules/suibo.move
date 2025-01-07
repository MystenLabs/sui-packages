module 0x58e39e099706a5a882a3bb7d57aa7452930be49b7af065edff10422461109074::suibo {
    struct SUIBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBO>(arg0, 6, b"SUIBO", b"SUIBoBo", b"BoBo On Sui $SUIBO ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tg_GS_68_Qj_400x400_8af8e979e4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

