module 0xfc7020881a7ba46877673fc83b81e3d891dbf5720407d80ecc98d9bfc2afd103::jose {
    struct JOSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOSE>(arg0, 6, b"JOSE", b"Jose", b"letter j", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ivory-neighbouring-harrier-779.mypinata.cloud/ipfs/QmRysNp9Jp3zLL8Em2fgouvBKLU2yDrHphsH2QodiHia91")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<JOSE>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<JOSE>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

