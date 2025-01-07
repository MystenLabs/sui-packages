module 0xaae38468c7de892d4548e6bec4d0a19fdfccf3c3dfcbc166fc05d8fce1f85ca0::ken {
    struct KEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEN>(arg0, 6, b"KEN", b"KEN'S ANGEL", b"KEN'S ANGEL SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x69dbd49d0fa823021520e376562c4fd7fa22f4d0_3f544e6f4e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

