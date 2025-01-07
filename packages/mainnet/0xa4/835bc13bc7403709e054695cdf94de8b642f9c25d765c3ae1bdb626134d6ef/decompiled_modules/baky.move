module 0xa4835bc13bc7403709e054695cdf94de8b642f9c25d765c3ae1bdb626134d6ef::baky {
    struct BAKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAKY>(arg0, 6, b"BAKY", b"BAKY SUI", x"62696720657965732062616b792074686520646f67206f6e205375690a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_00_38_30_fbaefeb8c9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

