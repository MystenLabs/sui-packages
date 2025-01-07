module 0x6353041cb26b309d153abf4223c02662250ca152c586d399f63505e3557639db::ryoshi {
    struct RYOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RYOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RYOSHI>(arg0, 9, b"RYOSHI", b"Sui Ryoshi", b"Sui Ryoshi just dropped on SUI, and it's lit! This token's got the vibes of a chill sunrise and the wisdom of some ancient master, all rolled into one.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FCaptura_de_tela_2024_10_04_232209_a425fe275c.png&w=640&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RYOSHI>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RYOSHI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RYOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

