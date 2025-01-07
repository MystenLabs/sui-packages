module 0x92e37be513e360119efbe3e3c7f06351665511d6de535701a2e01ce25249d006::suibidi {
    struct SUIBIDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBIDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBIDI>(arg0, 6, b"SUIBIDI", b"SUIBIDI TOILET", b"Suibidi is a parody of Skibidi Toiletis amachinima (https://en.m.wikipedia.org/wiki/Machinima)web series (https://en.m.wikipedia.org/wiki/Web_series)released throughYouTube (https://en.m.wikipedia.org/wiki/YouTube), Suibidi is first skibidi Toilet on Sui meme token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TOLIR_e54a7b29e3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBIDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBIDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

