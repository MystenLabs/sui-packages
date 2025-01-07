module 0x71455e740467bae474a712c8cfbff8e093544c082b01a2cee312519d9f32d2d9::zeusui {
    struct ZEUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEUSUI>(arg0, 6, b"Zeusui", b"ZeuSUI", x"5355492020466972737420474f44205448454d45440a5a45555355490a505546464646464646464646210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ZEUS_HAS_A_WATE_164d57c5_84b5_4887_954d_02c605b7d051_9f36f498e6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEUSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZEUSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

