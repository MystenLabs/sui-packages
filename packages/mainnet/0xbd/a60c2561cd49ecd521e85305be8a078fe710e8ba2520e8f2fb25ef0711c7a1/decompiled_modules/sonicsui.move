module 0xbda60c2561cd49ecd521e85305be8a078fe710e8ba2520e8f2fb25ef0711c7a1::sonicsui {
    struct SONICSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONICSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONICSUI>(arg0, 6, b"SonicSui", b"Sonic", b"The hedgehog is here to fight the cats and dogs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000037323_8296e62a95.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONICSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SONICSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

