module 0x7e520a3e01e5131a23dab538680285d971b0a133a676b1f2443336c14753fc7e::splatter {
    struct SPLATTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLATTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLATTER>(arg0, 6, b"Splatter", b"TrumpWifShart", b"Trump Sharting. Plenty of velocity and splatter! The utility is in the splatter. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6724_60112b79e1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLATTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPLATTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

