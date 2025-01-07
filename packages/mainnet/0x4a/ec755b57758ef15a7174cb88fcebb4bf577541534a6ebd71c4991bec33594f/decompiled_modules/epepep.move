module 0x4aec755b57758ef15a7174cb88fcebb4bf577541534a6ebd71c4991bec33594f::epepep {
    struct EPEPEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: EPEPEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EPEPEP>(arg0, 6, b"EPEPEP", b"EPEP", x"4550454545454550505050500a0a4b494c4c205448452050455045", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7137_f8a5495908.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EPEPEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EPEPEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

