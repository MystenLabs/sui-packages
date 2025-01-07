module 0xa9a3929171bf23c58dcaaab1a62135f6f8284db833af43a1e7573f76318cd7ce::fireboy {
    struct FIREBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIREBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIREBOY>(arg0, 6, b"FIREBOY", b"FIREBOY on SUI", b"$FIREBOY  is upset that watergirl cheated on him and wants to get revenge on her and on all the memecoins in the market, he promised that his revenge is to become the biggest memecoin in the market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241203_233754_128_47cb937269.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIREBOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIREBOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

