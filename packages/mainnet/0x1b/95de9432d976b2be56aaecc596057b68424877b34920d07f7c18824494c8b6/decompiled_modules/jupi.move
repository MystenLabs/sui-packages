module 0x1b95de9432d976b2be56aaecc596057b68424877b34920d07f7c18824494c8b6::jupi {
    struct JUPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUPI>(arg0, 6, b"JUPI", b"Sui Jupi", b"Being in the deep sea makes Jupi calm and relaxed, but he misses the waves of Sui.  While he enjoys the serenity below, his heart longs for the thrill and energy of riding those iconic waves. Jupi knows that the best of both worlds awaits him! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karya_Seni_Tanpa_Judul_84_9d4be033b3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

