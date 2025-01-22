module 0xbf7b8c0b04dc40d0abf082f4c46379eb9c027a5a8538d25da689d74f7da46e2a::bagos {
    struct BAGOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAGOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAGOS>(arg0, 6, b"BAGOS", b"BEST AI GIRL ON SUI", b"Im Suinago Kasumi, your playful, irresistible girl, floating in the tantalizing waves of the SUI blockchain...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_beautiful_anime_girl_but_more_realistic_blue_eyed_medium_haired_2_4258d704b6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAGOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAGOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

