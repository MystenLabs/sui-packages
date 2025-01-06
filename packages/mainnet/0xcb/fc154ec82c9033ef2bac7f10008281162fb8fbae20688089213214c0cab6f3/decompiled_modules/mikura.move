module 0xcbfc154ec82c9033ef2bac7f10008281162fb8fbae20688089213214c0cab6f3::mikura {
    struct MIKURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKURA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKURA>(arg0, 6, b"MIKURA", b"MikuraAi", b"$MIKURA is the first to blend music with Sui blockchain technology. They are pioneering this unique narrative. This is the first time I've seen a compelling AI narrative; other AI tokens might share similar utilities or narratives, but $MIKURA is built differently.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250107_035414_123_438af87ca7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKURA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIKURA>>(v1);
    }

    // decompiled from Move bytecode v6
}

