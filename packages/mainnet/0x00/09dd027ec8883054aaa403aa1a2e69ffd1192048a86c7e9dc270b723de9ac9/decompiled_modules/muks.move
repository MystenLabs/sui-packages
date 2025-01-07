module 0x9dd027ec8883054aaa403aa1a2e69ffd1192048a86c7e9dc270b723de9ac9::muks {
    struct MUKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUKS>(arg0, 6, b"MUKS", b"Eln Muks", b"i am a spacemen muks v smar go mar umg muks musk coloniz mars uhm smar ha har. eln muks har har smar eln colonisez Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/portal_7c7f974c00.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

