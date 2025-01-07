module 0x4fb6c78cdfb5687a7c74cc0b551722629c700d7f0a0a79004ddff90e4fcedb61::vone {
    struct VONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VONE>(arg0, 6, b"VONE", b"VersionOne", b".", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLE_2024_07_0217_05_00_Amajesticmountainlandscapewithsnow_cappedpeakslushgreenforestsandaclearbluesky_Theforegroundfeaturesaserenealpinelakereflectin_ezgif_com_webp_to_jpg_converter_9d975a2293.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

