module 0x3d8aa642d49860eb4b5ac8998cd67f5e37f613a61114bf4b52ef5a929eb9319c::blinky {
    struct BLINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLINKY>(arg0, 6, b"BLINKY", b"SuiBlinky", b"Blinky the Three-Eyed Fish (or simply Blinky) is a three-eyed orange fish species, found in the ponds and lakes outside the nuclear power plant.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1uhewzl6_400x400_77d1c0dab1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLINKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLINKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

