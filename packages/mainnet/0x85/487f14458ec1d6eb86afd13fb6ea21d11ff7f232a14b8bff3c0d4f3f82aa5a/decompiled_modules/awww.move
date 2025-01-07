module 0x85487f14458ec1d6eb86afd13fb6ea21d11ff7f232a14b8bff3c0d4f3f82aa5a::awww {
    struct AWWW has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWWW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWWW>(arg0, 6, b"AWWW", b"wewe", b"blok", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjRjiptQ8yprOpbMwdQnensIw5cAtf0nGxopcNlXGstFD9csnGTL6dB21Y6RWtVyFEmnYWrsAtvj_xfT1bbDW7kghwZSz8tqVlKJ1PM_WHaX-1w7IR62qoZU9Saadsx-sJ7MvZou5QeUWGM237KBaUhUl-xwxE1LHqhp8N-oT5dHwHFGDB9K3ZKAQ51Z4s/s16000/9%201456x90.gif")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<AWWW>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<AWWW>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

