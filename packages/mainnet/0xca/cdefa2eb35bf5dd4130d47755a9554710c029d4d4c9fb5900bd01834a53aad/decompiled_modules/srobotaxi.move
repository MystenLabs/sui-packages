module 0xcacdefa2eb35bf5dd4130d47755a9554710c029d4d4c9fb5900bd01834a53aad::srobotaxi {
    struct SROBOTAXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SROBOTAXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SROBOTAXI>(arg0, 6, b"sRobotaxi", b"sui Robotaxi", b"Sui rides forward in a Tesla. There's no Telegram, no Twitter, no websitejust a single image.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/d5457e5c980b5023b6657d94cf0483e_3baa743bbe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SROBOTAXI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SROBOTAXI>>(v1);
    }

    // decompiled from Move bytecode v6
}

