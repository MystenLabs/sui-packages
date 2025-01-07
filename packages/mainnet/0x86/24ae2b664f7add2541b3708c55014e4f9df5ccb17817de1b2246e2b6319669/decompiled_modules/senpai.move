module 0x8624ae2b664f7add2541b3708c55014e4f9df5ccb17817de1b2246e2b6319669::senpai {
    struct SENPAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENPAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SENPAI>(arg0, 3, b"SENPAI", b"Senpai", b"A good friend", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://scontent.fmdq7-1.fna.fbcdn.net/v/t39.30808-6/313364298_107298908850176_1603480705435923664_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=efb6e6&_nc_ohc=EY4Zm2Hxq4kAX95fGIj&_nc_ht=scontent.fmdq7-1.fna&oh=00_AfAeZzfZJaVeTZSWxcxKDUWUtKd8t4Cb7tO86NURan3emg&oe=65C7856E")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SENPAI>(&mut v2, 300000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENPAI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SENPAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

