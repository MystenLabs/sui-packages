module 0x41dea7597a8af6fae5a8bacc5ac52055966ba10ba1b6af1ba50ab935c525f07e::omg {
    struct OMG has drop {
        dummy_field: bool,
    }

    fun init(arg0: OMG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OMG>(arg0, 8, b"OMG", b"OMEGA", b"SUI OMEGA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tse1.mm.bing.net/th?id=OIP.0_dBZ1qV-ytXfeX7yLIxGAHaFv&pid=Api&P=0&h=180")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OMG>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OMG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OMG>>(v1);
    }

    // decompiled from Move bytecode v6
}

