module 0xbf83639c4a3dbda53d8dca37b809ff7d94dafd9010870016e1501ae130f8be9a::fun {
    struct FUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUN>(arg0, 6, b"FUN", b"HOPFUN", b"HOPFUN is a playful token on the Sui network designed to bring excitement and fun to the blockchain experience", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/58w40Zj/G9-NH-V7z-400x400.jpg")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<FUN>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<FUN>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

