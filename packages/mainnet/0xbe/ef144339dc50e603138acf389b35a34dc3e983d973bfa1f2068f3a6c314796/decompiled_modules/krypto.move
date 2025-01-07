module 0xbeef144339dc50e603138acf389b35a34dc3e983d973bfa1f2068f3a6c314796::krypto {
    struct KRYPTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRYPTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRYPTO>(arg0, 6, b"KRYPTO", b"Superman's Dog", b"Krypto the Super Dog is Superman's latest sidekick announced in the upcoming Jame's Gunn SUPERMAN film. Now you can join the moon misssion to Krypton with a chart that goes higher and faster than a speeding bullet. Krypto the Super Dog is ready to blast on to the Ethereum meme scene. If you missed Doge, Shiba, Neiro then you won't want to miss out on Krypto!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000006318_a843250394.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRYPTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KRYPTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

