module 0xee9d0d05e2d82f0bfb452da205c50197730586a6254740e15d026591ea0d53cb::suoiia {
    struct SUOIIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUOIIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUOIIA>(arg0, 6, b"SUOIIA", b"SuOIIA", b"Oo Ee A E A", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/C7o_GMZ_unscreen_ezgif_com_crop_7a6366ffd2.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUOIIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUOIIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

