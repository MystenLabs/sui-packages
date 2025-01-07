module 0x17f1e339f4b27f6c17eace0b0e2e4dab4c9008cf68823e0a9874b6e939745a5c::vvp_1 {
    struct VVP_1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: VVP_1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VVP_1>(arg0, 6, b"VVP1", b"VVP 1", b"This is it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ivory-neighbouring-harrier-779.mypinata.cloud/ipfs/QmVQ3EqrXd2Eu895tLyLTbgEHjY93mTgtrN1NPiFNRqmXp")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<VVP_1>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<VVP_1>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

