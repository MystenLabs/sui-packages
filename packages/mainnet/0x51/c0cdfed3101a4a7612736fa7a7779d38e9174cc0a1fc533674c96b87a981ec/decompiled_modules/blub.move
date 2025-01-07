module 0x51c0cdfed3101a4a7612736fa7a7779d38e9174cc0a1fc533674c96b87a981ec::blub {
    struct BLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUB>(arg0, 6, b"BLUB", b"BLUB SUI", b"$BLUB is the funniest and most degenerate fish in the Sui Ocean, staying true to its origins and bringing the chaotic energy of the 'Boy's Club'the creators of $PEPEto the Sui Network. With its dirty and clumsy manner, $BLUB causes real chaos in the coral. It brings a unique theme and perfect synergy with the Sui Network, making it an irresistible crypto for those who love memes and aspire to conquer oceans and achieve dreams.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BLUB_3f53b8cd0b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

