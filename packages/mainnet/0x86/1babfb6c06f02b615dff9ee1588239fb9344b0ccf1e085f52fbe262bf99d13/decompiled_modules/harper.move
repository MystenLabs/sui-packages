module 0x861babfb6c06f02b615dff9ee1588239fb9344b0ccf1e085f52fbe262bf99d13::harper {
    struct HARPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARPER>(arg0, 9, b"HARPER", b"Dillion Harper", b"Dillion Harper is the original cute mascot of the Sui blockchain ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://sun9-31.userapi.com/s/v1/ig2/URdIizsh643tFsa2bs0CX0OAzhrc-bQVuoDjbguhK_e1Wl6NLetqpbvR3PZfSFG2oRUdWFAj7Ryv981kEZhIa2W8.jpg?quality=96&as=32x32,48x48,72x72,108x108,160x160,240x240,360x360,480x480,540x540,640x640,720x720,1080x1080,1280x1280,1440x1440&from=bu&u=ElZ12sIo0T7_Q62Abv4TyWnC5YNgSkFNTftPvF_Bglw&cs=807x807")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HARPER>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARPER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HARPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

