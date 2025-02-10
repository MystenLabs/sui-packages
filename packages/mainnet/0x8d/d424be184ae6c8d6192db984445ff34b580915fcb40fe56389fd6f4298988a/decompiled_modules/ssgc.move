module 0x8dd424be184ae6c8d6192db984445ff34b580915fcb40fe56389fd6f4298988a::ssgc {
    struct SSGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSGC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSGC>(arg0, 9, b"SSGC", b"ShadowSuiGalacticCollectible", b"In the year 3023, the ShadowSui NFT launchpad revolutionized the galaxy by introducing the first interstellar collectibles. These unique tokens, inspired by ancient alien artifacts, were discovered on a distant planet and brought back to Earth by a daring crew. The launchpad's CEO, Zorba the Magnificent, decided to create a new type of NFT that could be collected and traded among space enthusiasts. The tokens quickly became a hit, with collectors from all over the universe clamoring to get their hands on these rare and valuable collectibles. The ShadowSuiGalacticCollectible token is now a must-have for any serious space trader or alien artifact enthusiast.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/dstqcb0lj/image/upload/v1739207925/ycmk8oo5vhm1sgufywar.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSGC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSGC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

