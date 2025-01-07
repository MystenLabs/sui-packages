module 0x8479a4506a3582f30484014247eaac17049258ea7fd6377aa9b2e6a553948fbc::PEPE {
    struct PEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPE>(arg0, 6, b"$PEPE", b"Pepe Army Token", b"Meme coin based on Pepe built on Sui Network, Telegram :https://t.me/pepearmysui @pepearmysui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pepearmy.online/wp-content/uploads/2023/05/Untitled_design__7_-removebg-preview.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

