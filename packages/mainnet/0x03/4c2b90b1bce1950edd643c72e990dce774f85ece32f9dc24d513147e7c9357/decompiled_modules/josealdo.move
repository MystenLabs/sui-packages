module 0x34c2b90b1bce1950edd643c72e990dce774f85ece32f9dc24d513147e7c9357::josealdo {
    struct JOSEALDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOSEALDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOSEALDO>(arg0, 6, b"JOSEALDO", b"JOSE", b"jose aldo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ivory-neighbouring-harrier-779.mypinata.cloud/ipfs/QmZDnqHx8bR6cbL8nnXqguLshkvE8UGrzkK7GUXWzWYPYy")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<JOSEALDO>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<JOSEALDO>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

