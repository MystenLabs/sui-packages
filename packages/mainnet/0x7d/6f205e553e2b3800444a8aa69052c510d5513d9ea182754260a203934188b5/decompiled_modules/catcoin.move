module 0x7d6f205e553e2b3800444a8aa69052c510d5513d9ea182754260a203934188b5::catcoin {
    struct CATCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATCOIN>(arg0, 6, b"CAT", b"CatCoin", b"CatCoin is the ultimate token for cat lovers!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://icons.iconarchive.com/icons/iconarchive/incognito-animal-2/256/Cat-icon.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<CATCOIN>>(0x2::coin::mint<CATCOIN>(&mut v2, 25000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATCOIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

