module 0x47c103180a14e2215d95b80a30f0471924108911a58f23f25e06bd5fd56cd251::suixxx {
    struct SUIXXX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIXXX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIXXX>(arg0, 6, b"SUIXXX", b"SUI6900", b"$SUI6900 is just another totally unnecessary meme token on Sui blockchain, because apparently we didn't have enough of these already. No fancy tokenomics, no \"revolutionary\" burn mechanismsjust pure, unadulterated internet nonsense with a number that makes 12-year-olds giggle. Created by someone who probably should have gone outside more, $SUI6900 has absolutely zero utility and is proud of it. Join our community of sleep-deprived degens who think putting \"6900\" on things is the pinnacle of comedy. Moon? Mars? Nah, we're aiming for your friend's couch, where you'll be sleeping after your partner finds out you bought this.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/index_a48e4cddd5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIXXX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIXXX>>(v1);
    }

    // decompiled from Move bytecode v6
}

