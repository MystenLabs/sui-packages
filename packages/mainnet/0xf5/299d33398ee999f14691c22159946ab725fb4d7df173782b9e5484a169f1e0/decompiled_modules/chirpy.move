module 0xf5299d33398ee999f14691c22159946ab725fb4d7df173782b9e5484a169f1e0::chirpy {
    struct CHIRPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIRPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIRPY>(arg0, 6, b"CHIRPY", b"HAPPY BIRD", b" Chirp Your Way, Say What You Want! The happiest parrot in the crypto world. Bringing joy, memes, and free speech to the flock. Join the Chirpy Revolution!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zyu_JL_Hyi_400x400_ac3304258f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIRPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIRPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

