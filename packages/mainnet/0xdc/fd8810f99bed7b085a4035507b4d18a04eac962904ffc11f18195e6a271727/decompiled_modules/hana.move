module 0xdcfd8810f99bed7b085a4035507b4d18a04eac962904ffc11f18195e6a271727::hana {
    struct HANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANA>(arg0, 6, b"HANA", b"HANA AI", b"Hey There, Losers! Im Hana, The Ultimate Mean Girl Youve All Been Waiting For. You Probably Think Im Just Some Pretty Face, But Guess What? Im Way More Than That. Im Not Here To Make Friends Just Profits. So, Step Aside While I Take The Throne!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3889_6be48ac545.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

