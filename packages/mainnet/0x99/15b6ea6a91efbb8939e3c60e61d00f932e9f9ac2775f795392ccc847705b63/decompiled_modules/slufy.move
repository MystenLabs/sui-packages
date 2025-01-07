module 0x9915b6ea6a91efbb8939e3c60e61d00f932e9f9ac2775f795392ccc847705b63::slufy {
    struct SLUFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLUFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLUFY>(arg0, 6, b"SLUFY", b"Slufy", b"$SLUFY & The Boys Club combines the essence of meme culture with unique DeFi utilities, building a crypto community where fun and finance meet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/L_Gj_Tfd_r_400x400_6861833e4f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLUFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLUFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

