module 0xc455bda86828c260e76bff0c997ca53bd07fb4ae357e14af27e7674320cc3925::supea {
    struct SUPEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPEA>(arg0, 6, b"SUPEA", b"Supea", x"4d414b452053554920544f4b454e5320475245415420414741494e210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_14_16_54_24_5c947792bb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

