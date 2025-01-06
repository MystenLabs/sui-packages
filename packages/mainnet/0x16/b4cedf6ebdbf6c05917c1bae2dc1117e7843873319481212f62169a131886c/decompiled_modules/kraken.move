module 0x16b4cedf6ebdbf6c05917c1bae2dc1117e7843873319481212f62169a131886c::kraken {
    struct KRAKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRAKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRAKEN>(arg0, 6, b"KRAKEN", b"CaptainKraken", b"The legendary kraken of the seven seas, calls upon daring souls to join his fearless crew! Together, well sail the roaring waves aboard The Abyssal Tide in search of the fabled Buried Treasure Chest, said to hold secrets beyond imagination.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_1_adfc640d2e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRAKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KRAKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

