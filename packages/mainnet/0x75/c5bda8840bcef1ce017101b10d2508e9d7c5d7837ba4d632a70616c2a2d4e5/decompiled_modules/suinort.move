module 0x75c5bda8840bcef1ce017101b10d2508e9d7c5d7837ba4d632a70616c2a2d4e5::suinort {
    struct SUINORT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINORT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINORT>(arg0, 6, b"SUINORT", b"SNORT ON SUI", b"Yo, Im SNORT on Base - This is the OLD & ORIGINAL account, follow the new one ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SNORT_91658ef7a5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINORT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINORT>>(v1);
    }

    // decompiled from Move bytecode v6
}

