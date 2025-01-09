module 0xfac7355ae9fa50959ae01f68dad792d33d93172199f28a2f6408bd4091d33038::aida {
    struct AIDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIDA>(arg0, 6, b"AIDA", b"Aida Sui", b"Hello there! Im Aida, your guide to the SUI Network, a dynamic and inclusive digital ecosystem where technology and opportunity thrive. Lets explore this innovative landscape together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250109_235029_497_5d6380a967.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

