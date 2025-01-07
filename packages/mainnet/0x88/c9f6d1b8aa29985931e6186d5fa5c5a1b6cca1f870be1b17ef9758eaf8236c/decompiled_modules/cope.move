module 0x88c9f6d1b8aa29985931e6186d5fa5c5a1b6cca1f870be1b17ef9758eaf8236c::cope {
    struct COPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COPE>(arg0, 6, b"COPE", b"Cope Harder", b"Bought the top? Used as exit liquidity? Stuck with worthless bags? $COPE is here to help you cope. $COPE isn't just a token; it's a community movement. Turn past regrets into future gains. We embody resilience and solidarity. Even your worst trades can lead to wealth. Ready to embrace FOMO and turn mistakes into profits? Join the $COPE movement. With $COPE, coping is the new winning!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_a8c7b22157.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

