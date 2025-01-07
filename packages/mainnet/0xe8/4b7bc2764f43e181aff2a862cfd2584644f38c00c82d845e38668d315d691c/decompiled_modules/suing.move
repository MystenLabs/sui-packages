module 0xe84b7bc2764f43e181aff2a862cfd2584644f38c00c82d845e38668d315d691c::suing {
    struct SUING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUING>(arg0, 6, b"Suing", b"Suing on Sui", b"Just a Suing on Sui..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1275_01046b40aa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUING>>(v1);
    }

    // decompiled from Move bytecode v6
}

