module 0x1eb9ee58f2acb7a7f3ff37ca983c8a27b05a2aa245be29bd5dad07ef30100e06::mimi {
    struct MIMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIMI>(arg0, 6, b"MIMI", b"MimiOnSui", b"$MIMI is a meme-coin based on Sui Blockchain. Your gateway to time-traveling adventures in the crypto world. Grab the opportunities you missed with every tick of the clock and reshape your digital destiny.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000529_3f4d288102.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

