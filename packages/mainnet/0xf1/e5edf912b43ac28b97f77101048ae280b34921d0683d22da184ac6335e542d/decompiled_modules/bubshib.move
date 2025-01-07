module 0xf1e5edf912b43ac28b97f77101048ae280b34921d0683d22da184ac6335e542d::bubshib {
    struct BUBSHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBSHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBSHIB>(arg0, 6, b"BUBSHIB", b"BUBBLE SHIBA SUI", b"Its me, Bubble!website : bubbleonsui.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3841_00f2dc2711.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBSHIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBSHIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

