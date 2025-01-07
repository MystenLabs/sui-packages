module 0x4d1f92b8755f95b776842471fd8e7cda176ee18712c3c46723641a100caf91c::cobycatsui {
    struct COBYCATSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: COBYCATSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COBYCATSUI>(arg0, 6, b"Cobycatsui", b"Coby cat sui", b"We love blue eyed coby cat sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241022_232501_971_6774255e68.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COBYCATSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COBYCATSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

