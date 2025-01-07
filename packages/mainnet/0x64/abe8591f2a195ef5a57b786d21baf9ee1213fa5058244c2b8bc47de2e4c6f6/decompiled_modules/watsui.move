module 0x64abe8591f2a195ef5a57b786d21baf9ee1213fa5058244c2b8bc47de2e4c6f6::watsui {
    struct WATSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATSUI>(arg0, 6, b"WATSUI", b"PWATSUI", x"5061756c205761747375692c207468652053554920446566656e64657220210a4a6f696e207573206f6e205477697474657220616e642054656c656772616d20210a4c6574277320646566656e642074686520535549206f6365616e20746f6765746865722021", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_WATSUI_cc5d5f9a3e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WATSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

