module 0xe225209f6a8ec125d2ab1ba75489aff9fa69307d0c066e8b90336912c0e13baa::hnyan {
    struct HNYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HNYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HNYAN>(arg0, 6, b"HNYAN", b"Japans First Mascot Hikonyan", b"The first Yuru-Chara Grand Prix (a popular contest in Japan for regional mascots) was held in 2010, and the winner was Hikonyan, the official mascot of Hikone City in Shiga Prefecture. Hikonyan is a white cat wearing a samurai helmet, created in 2007", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048497_ef9f0b04b3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HNYAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HNYAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

