module 0x1f22ed2684945c3c8cf9e4de533e6591f8a5894f22da53e23f265473b36c0b64::dmaga {
    struct DMAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMAGA>(arg0, 6, b"DMAGA", b"SUI DARK MAGA", b"Dark MAGA patriots in control", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241006_025222_ed44db3afe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DMAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

