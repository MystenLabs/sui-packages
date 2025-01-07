module 0xdcbd1c09d95240c07acf5202f76927cfb701ab3a4cd70ca3bb58ff3d33a1aa91::roshi {
    struct ROSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROSHI>(arg0, 6, b"ROSHI", b"Pepe Roshi", b"Pepe Roshi is a perverted Hermit and master of martial arts fueled on @SuiNetwork.  He lives on his own isolated island called Kame House, where he may be willing to train students who travel to his doorstep. He is also the originator of the Kamehameha.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/roshi_2af779c3a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

