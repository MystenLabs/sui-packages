module 0x9c7fd10d13232f471dd75f093287ea181a051c5975ee6330e82b822bc02fed77::fritz {
    struct FRITZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRITZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRITZ>(arg0, 6, b"FRITZ", b"FritzOnSui", b"World famous hippo, Fritz  (little brother to Fiona) recently turned 2 years old ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fritz_c7a1ab2498.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRITZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRITZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

