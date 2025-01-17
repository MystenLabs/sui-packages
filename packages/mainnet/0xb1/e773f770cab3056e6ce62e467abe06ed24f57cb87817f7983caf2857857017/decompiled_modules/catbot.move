module 0xb1e773f770cab3056e6ce62e467abe06ed24f57cb87817f7983caf2857857017::catbot {
    struct CATBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATBOT>(arg0, 6, b"CATBOT", b"A.I. Catgents Coin", b"\"A.I. Catgents Coin merges the AI craze, cat memes, and secret-agent vibes to create a whimsical 'AI Special Agent Cat' universe. CATBOT uses absurdity, humor, and irresistible cuteness to let you indulge in the frenzy of crypto hype, always surrounded by an abundance of 'meow-energy'!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d55a942b_a3e0_4fe5_9df2_cfd73165bb19_4e01d67bbb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

