module 0x98a047732c81444d5b723fa9f18d8be3dd647a698b2ef6c2108e2e70ab797d0b::suiyancat {
    struct SUIYANCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIYANCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIYANCAT>(arg0, 9, b"SUIYANCAT", b"Suiyan Cat", b"The iconic nyan cat is pouncing its way on SUI, a legendary meme with a legendary branding   https://suiyancat.com/ https://t.me/suiyancat https://x.com/suiyancat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1728967217945-41c77c6600134793f684c9fc867d1e3b.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIYANCAT>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIYANCAT>>(v2, @0x546bb7ba0c5c7c7719a9c976bcce372c81e31d851b40d68aff5f3b2413c1578d);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIYANCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

