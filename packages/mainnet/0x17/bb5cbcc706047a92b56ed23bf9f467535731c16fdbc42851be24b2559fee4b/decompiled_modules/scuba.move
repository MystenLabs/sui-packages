module 0x17bb5cbcc706047a92b56ed23bf9f467535731c16fdbc42851be24b2559fee4b::scuba {
    struct SCUBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCUBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCUBA>(arg0, 6, b"SCUBA", b"SCUBA DOG", b"THE SCUBA DIVING DOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3568_fba0abac85.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCUBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCUBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

