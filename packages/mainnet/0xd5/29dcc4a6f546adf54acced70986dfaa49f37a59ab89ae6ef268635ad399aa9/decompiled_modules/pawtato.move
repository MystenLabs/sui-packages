module 0xd529dcc4a6f546adf54acced70986dfaa49f37a59ab89ae6ef268635ad399aa9::pawtato {
    struct PAWTATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO>(arg0, 6, b"PAWTATO", b"Pawtato", b"Pawtato It's a privilege to share the stage with such talented teams pushing the boundaries on @SuiNetwork.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250508_021910_c8d3383582.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAWTATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

