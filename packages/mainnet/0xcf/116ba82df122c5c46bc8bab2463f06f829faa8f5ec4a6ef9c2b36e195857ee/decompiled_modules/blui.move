module 0xcf116ba82df122c5c46bc8bab2463f06f829faa8f5ec4a6ef9c2b36e195857ee::blui {
    struct BLUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUI>(arg0, 6, b"BLUI", b"Blui on Sui", b"Blui, the popular mascot from the famous TV show is now on SUI! Cehck out the website, join the community and let's send this together. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_25_00_30_17_7888036e43.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

