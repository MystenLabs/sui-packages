module 0x2b4bdef516d3be044810287fc35f7879154ff3f090f969bba45d3b6f98793c9f::moodeng {
    struct MOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODENG>(arg0, 9, b"MOODENG", b"The Moodeng On Sui", b"The Moodeng fan token deploy on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.bittime.com%2Fen%2Fblog%2Fkoin-moodeng-viral-tokenomics-dan-sejarah&psig=AOvVaw1bYMY1zpnhM4ygbaoCBA1H&ust=1733822249273000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCKCyuqmtmooDFQAAAAAdAAAAABAE")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOODENG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODENG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

