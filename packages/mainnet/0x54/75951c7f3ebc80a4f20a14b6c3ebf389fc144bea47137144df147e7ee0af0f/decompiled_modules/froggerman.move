module 0x5475951c7f3ebc80a4f20a14b6c3ebf389fc144bea47137144df147e7ee0af0f::froggerman {
    struct FROGGERMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGGERMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGGERMAN>(arg0, 9, b"FMAN", b"froggerman", b"here to save you from yourself. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/9ab1dbbf-f018-46d2-82ff-3f797e3e371f.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FROGGERMAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGGERMAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

