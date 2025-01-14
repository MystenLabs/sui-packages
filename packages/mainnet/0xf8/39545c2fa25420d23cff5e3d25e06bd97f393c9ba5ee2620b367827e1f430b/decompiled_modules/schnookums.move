module 0xf839545c2fa25420d23cff5e3d25e06bd97f393c9ba5ee2620b367827e1f430b::schnookums {
    struct SCHNOOKUMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCHNOOKUMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCHNOOKUMS>(arg0, 6, b"SCHNOOKUMS", b"Schnookums", b"Just the cutest cat in the Suiverse. Schnookums is just here for cuddles and fun. Like Sui, his color is blue. No socials. Will burn 3% at 50% bonding. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/360_F_123262173_Fd_EDY_2vr_F4ww5c_O7f6_Rouuk_Vs_JGZRBEW_e18b4053f5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCHNOOKUMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCHNOOKUMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

