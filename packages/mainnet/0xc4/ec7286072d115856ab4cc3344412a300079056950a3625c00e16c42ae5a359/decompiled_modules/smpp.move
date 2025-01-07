module 0xc4ec7286072d115856ab4cc3344412a300079056950a3625c00e16c42ae5a359::smpp {
    struct SMPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMPP>(arg0, 6, b"SMPP", b"Sui Move PumP", b"The Sui Move Pump meme coin on the Sui blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SMPP_cc3a901733.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMPP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMPP>>(v1);
    }

    // decompiled from Move bytecode v6
}

