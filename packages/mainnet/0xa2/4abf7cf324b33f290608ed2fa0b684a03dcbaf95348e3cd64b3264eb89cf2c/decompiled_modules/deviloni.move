module 0xa24abf7cf324b33f290608ed2fa0b684a03dcbaf95348e3cd64b3264eb89cf2c::deviloni {
    struct DEVILONI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEVILONI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEVILONI>(arg0, 6, b"DEVILONI", b"DevilOni On Sui", b"The first devil on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000521_9ef4c76ef2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEVILONI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEVILONI>>(v1);
    }

    // decompiled from Move bytecode v6
}

