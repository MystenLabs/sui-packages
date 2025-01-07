module 0x3e1668dff3233dc826f1afd1f693b9a057def8aa48eac18cf593bf51379bb9b2::pla {
    struct PLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLA>(arg0, 6, b"PLA", b"PEPULA", b"Born from the dark union between the legendary Pepe the Frog and the immortal Dracula, PEPULA is not a simple digital currency: it is a living entity, capable of sucking the lifeblood from the cryptocurrency market, only to be reborn more powerful than ever. website and game on going.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/foto_pepe_dracula_3_8b0c4a6f8d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

