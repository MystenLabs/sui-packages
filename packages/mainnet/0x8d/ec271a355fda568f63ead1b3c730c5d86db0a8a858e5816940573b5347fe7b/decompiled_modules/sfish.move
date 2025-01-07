module 0x8dec271a355fda568f63ead1b3c730c5d86db0a8a858e5816940573b5347fe7b::sfish {
    struct SFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFISH>(arg0, 6, b"SFISH", b"STARFISH", b"A starfish wandering in the sea, afraid of being eaten by big fish. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OW_8_MX_Ciy_400x400_07a51be6a5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

