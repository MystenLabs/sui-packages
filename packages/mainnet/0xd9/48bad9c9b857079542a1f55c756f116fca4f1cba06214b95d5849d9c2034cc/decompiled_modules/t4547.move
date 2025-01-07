module 0xd948bad9c9b857079542a1f55c756f116fca4f1cba06214b95d5849d9c2034cc::t4547 {
    struct T4547 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T4547, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T4547>(arg0, 6, b"T4547", b"TRUMP TRIBUTE", b"Introducing Trump Tribute: a meme token celebrating the potential return of Donald Trump to the presidency as both the 45th and 47th U.S. president. Trump Tribute embodies the spirit of a bold comeback, echoing Trumps iconic resilience and drive. Its design features unmistakable imagery that appeals to loyal supporters, with themes of empowerment, patriotism, and ambition. The token rallies a community of true believers and meme warriors, blending humor with admiration as it climbs the charts. Join the movement for Trumps triumphant resurgence and be part of the financial and cultural revolution! twitter and tg in the works!!! YUUGE!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_cf2b7b6458.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T4547>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<T4547>>(v1);
    }

    // decompiled from Move bytecode v6
}

