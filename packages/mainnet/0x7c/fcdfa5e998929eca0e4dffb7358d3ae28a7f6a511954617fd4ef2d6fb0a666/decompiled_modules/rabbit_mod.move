module 0x7cfcdfa5e998929eca0e4dffb7358d3ae28a7f6a511954617fd4ef2d6fb0a666::rabbit_mod {
    struct RABBIT_MOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RABBIT_MOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RABBIT_MOD>(arg0, 9, b"rabbit", b"rabbit mod", b"rabbit disguised as a duck ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/874b1da2-4ebd-428b-889a-0de973cf3b3c.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RABBIT_MOD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RABBIT_MOD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

