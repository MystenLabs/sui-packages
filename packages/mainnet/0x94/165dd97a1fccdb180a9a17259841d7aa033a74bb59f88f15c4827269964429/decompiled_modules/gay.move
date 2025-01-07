module 0x94165dd97a1fccdb180a9a17259841d7aa033a74bb59f88f15c4827269964429::gay {
    struct GAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAY>(arg0, 9, b"GAY", b"Gay Man", b"USA GAU USA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://mykaleidoscope.ru/x/uploads/posts/2022-10/1666338566_1-mykaleidoscope-ru-p-gei-otkritki-instagram-1.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GAY>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

