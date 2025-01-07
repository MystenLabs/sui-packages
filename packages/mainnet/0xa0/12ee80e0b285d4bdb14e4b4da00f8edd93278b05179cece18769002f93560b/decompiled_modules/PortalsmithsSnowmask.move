module 0xa012ee80e0b285d4bdb14e4b4da00f8edd93278b05179cece18769002f93560b::PortalsmithsSnowmask {
    struct PORTALSMITHSSNOWMASK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PORTALSMITHSSNOWMASK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PORTALSMITHSSNOWMASK>(arg0, 0, b"COS", b"Portalsmith's Snowmask", b"What lies beyond these Peaks? My companion, did you see?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Eyes_Portalsmith's_Snowmask.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PORTALSMITHSSNOWMASK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PORTALSMITHSSNOWMASK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

