module 0x9c813b700e975b612efbc602839cbdba80ac037a8bd13ec2d2d26d5e84bbd69b::AREUENT {
    struct AREUENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AREUENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AREUENT>(arg0, 6, b"Gladiator Coin", b"AREUENT", b"A meme coin inspired by the iconic Gladiator scene where he screams 'Are you not entertained!' This coin is for the true warriors of the crypto arena. Join the fight and prove your worth in the Colosseum of memes!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://replicate.delivery/xezq/lGz8eTDBP1UoPi4A0FZn3I8SvaOH1YKcMso92jV8R96evkGVA/out-0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AREUENT>>(v0, @0x2e0159a9e9b626b459363607236a4eeb1a03aae664d8000ce22e1187865b0c51);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AREUENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

