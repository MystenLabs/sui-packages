module 0xc630b3231e1e5a9375a670c20b7021d8d99050916e535d73f7f5fb19e290fcec::sbiao {
    struct SBIAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBIAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBIAO>(arg0, 6, b"SBIAO", b"Santa Biao", b"Ho-ho-ho, meet Santa Biao, the festive twist on the legendary Biao meme, now spreading cheer ! Santa Biao isnt just here for the holidayshes the ultimate gift-giver in the crypto space, bringing the meme game to a whole new level. Dressed in his jolly Santa outfit,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000050547_55bad7e316.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBIAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBIAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

