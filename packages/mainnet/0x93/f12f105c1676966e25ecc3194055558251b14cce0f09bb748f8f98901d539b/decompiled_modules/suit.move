module 0x93f12f105c1676966e25ecc3194055558251b14cce0f09bb748f8f98901d539b::suit {
    struct SUIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIT>(arg0, 9, b"Doge Wif Suit", b"SUIT", b"In the city of SuiChainVille, where cryptocurrency and technology reign supreme, there lived a unique dog named Doge. Despite his dapper appearance and successful investment skills, Doge was also known for his friendly demeanor. One day, Doge overheard a discussion about a new currency called SUI and decided to invest a large sum, ultimately becoming a millionaire. Other investors sought his advice, and Doge even opened a school to teach other dogs the art of investing. In the world of stylish and savvy dogs, Doge showed that with determination, anyone can find success. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1841362119947870209/Uf067lmt_400x400.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIT>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

