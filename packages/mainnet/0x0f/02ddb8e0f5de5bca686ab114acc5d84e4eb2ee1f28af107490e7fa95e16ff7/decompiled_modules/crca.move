module 0xf02ddb8e0f5de5bca686ab114acc5d84e4eb2ee1f28af107490e7fa95e16ff7::crca {
    struct CRCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRCA>(arg0, 6, b"CRCA", b"CRCLASSISANT", b"Cyril Ramaphosas cute little assistants scattered around the world. Support him! Our shared great leader.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wechat_IMG_198_c739c381a5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

