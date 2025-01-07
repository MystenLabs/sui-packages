module 0x30a6aef7030e4a5d769abf1355ce56e9bf8285187cd121834fbd499b3715f4cb::wmsui {
    struct WMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WMSUI>(arg0, 6, b"WMSUI", b"WatermanSui", b"Waterman, the super hero be water MF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000347_1c64fe19b3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WMSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WMSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

