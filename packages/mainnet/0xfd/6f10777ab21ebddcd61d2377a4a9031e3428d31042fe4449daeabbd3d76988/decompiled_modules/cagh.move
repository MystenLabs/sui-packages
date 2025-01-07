module 0xfd6f10777ab21ebddcd61d2377a4a9031e3428d31042fe4449daeabbd3d76988::cagh {
    struct CAGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAGH>(arg0, 6, b"CAGH", b"CatGhost", b"This cat is a ghost. Join TG!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1407443627548734_92a09685ff.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

