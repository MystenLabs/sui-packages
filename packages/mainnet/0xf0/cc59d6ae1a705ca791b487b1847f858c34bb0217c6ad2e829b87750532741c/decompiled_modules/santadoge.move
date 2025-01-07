module 0xf0cc59d6ae1a705ca791b487b1847f858c34bb0217c6ad2e829b87750532741c::santadoge {
    struct SANTADOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANTADOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANTADOGE>(arg0, 6, b"SANTADOGE", b"SantaDoge on SUI", b"Christmas is coming early this year!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CEFSPZ_1_G_400x400_cd0687684e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANTADOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANTADOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

