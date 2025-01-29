module 0x2b653d892e3169a88ddd6cafb1ee50602503b1c15ceb92037b212b3a4ef2238d::neogirl {
    struct NEOGIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEOGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEOGIRL>(arg0, 6, b"NeoGirl", b"Neocities Girl", b"Neocities Girl is an experimental AI-powered interactive fiction platform where your choices shape the narrative through direct character interactions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738163607110.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEOGIRL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEOGIRL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

