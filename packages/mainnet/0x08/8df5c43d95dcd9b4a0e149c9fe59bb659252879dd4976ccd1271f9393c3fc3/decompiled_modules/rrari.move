module 0x88df5c43d95dcd9b4a0e149c9fe59bb659252879dd4976ccd1271f9393c3fc3::rrari {
    struct RRARI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RRARI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RRARI>(arg0, 6, b"RRARI", b"SUI RRARI", b"Sui Rrari, The Ultimate Status Symbol.  Experience the thrill of exclusivity with SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bz_CTCVO_400x400_7b76c4e16e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RRARI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RRARI>>(v1);
    }

    // decompiled from Move bytecode v6
}

