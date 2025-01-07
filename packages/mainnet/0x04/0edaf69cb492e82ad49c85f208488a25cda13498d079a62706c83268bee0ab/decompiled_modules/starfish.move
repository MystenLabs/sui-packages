module 0x40edaf69cb492e82ad49c85f208488a25cda13498d079a62706c83268bee0ab::starfish {
    struct STARFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARFISH>(arg0, 6, b"STARFISH", b"STARFISHSUI", b"Transparency is the key ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018284_d3a7ef49c8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STARFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

