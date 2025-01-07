module 0x9c410ca0a051e016180cf34728a1d624d203acd9cb0650d69443a97eb552df5::ScorchedVentHardHat {
    struct SCORCHEDVENTHARDHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCORCHEDVENTHARDHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCORCHEDVENTHARDHAT>(arg0, 0, b"COS", b"Scorched Vent HardHat", b"Dangerous to dig... but treasure awaits!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Scorched_Vent_HardHat.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCORCHEDVENTHARDHAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCORCHEDVENTHARDHAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

