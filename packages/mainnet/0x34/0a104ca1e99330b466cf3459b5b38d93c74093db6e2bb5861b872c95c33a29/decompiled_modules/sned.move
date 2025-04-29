module 0x340a104ca1e99330b466cf3459b5b38d93c74093db6e2bb5861b872c95c33a29::sned {
    struct SNED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNED>(arg0, 6, b"SNED", b"Sned", b"Sned it!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pump_IMG_b564af9f11.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNED>>(v1);
    }

    // decompiled from Move bytecode v6
}

