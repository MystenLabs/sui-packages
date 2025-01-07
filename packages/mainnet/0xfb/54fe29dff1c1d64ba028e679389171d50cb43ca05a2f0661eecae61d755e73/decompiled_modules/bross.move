module 0xfb54fe29dff1c1d64ba028e679389171d50cb43ca05a2f0661eecae61d755e73::bross {
    struct BROSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROSS>(arg0, 6, b"BROSS", b"Bross", b"We created this token to strengthen the bonds among members of the crypto community. With $BROSS, you are not just part of an ecosystem, but you also take part in shaping the development of this token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241120_012532_50c1082a69.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BROSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

