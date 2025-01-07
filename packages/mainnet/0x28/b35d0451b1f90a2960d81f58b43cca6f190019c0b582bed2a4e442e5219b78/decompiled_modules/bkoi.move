module 0x28b35d0451b1f90a2960d81f58b43cca6f190019c0b582bed2a4e442e5219b78::bkoi {
    struct BKOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BKOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BKOI>(arg0, 6, b"BKOI", b"BABY KOI", b"Baby Koi A Bold Fish Making Waves of Wealth in the Sui Ocean ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/KOI_158fbe1dac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BKOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BKOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

