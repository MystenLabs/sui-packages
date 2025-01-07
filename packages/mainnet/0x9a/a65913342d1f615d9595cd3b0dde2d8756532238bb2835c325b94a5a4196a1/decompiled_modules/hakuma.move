module 0x9aa65913342d1f615d9595cd3b0dde2d8756532238bb2835c325b94a5a4196a1::hakuma {
    struct HAKUMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAKUMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAKUMA>(arg0, 6, b"HAKUMA", b"Hakuma on SUI", x"4275792048616b756d61204e6f7721200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma_ASFKV_400x400_28cbedf695.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAKUMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAKUMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

