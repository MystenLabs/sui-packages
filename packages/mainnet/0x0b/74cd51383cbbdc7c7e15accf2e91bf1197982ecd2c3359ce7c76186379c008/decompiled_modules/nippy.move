module 0xb74cd51383cbbdc7c7e15accf2e91bf1197982ecd2c3359ce7c76186379c008::nippy {
    struct NIPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIPPY>(arg0, 6, b"NIPPY", b"Nippy", b"Sometimes penguin sometimes cat.. CTO No socials Free for all Send it to popcat of sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1067_82ebb2eab4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

