module 0x2b473ecb6610863cb7b899b0032977a6a1b460af6e2560b944c7eafd8cb77a1b::bwal {
    struct BWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWAL>(arg0, 6, b"BWal", b"BABYWALRUS", b"$BWal is an innovative memecoin on the Sui blockchain that aims to unify the myriad of Walrus -themed cryptocurrencies under one powerful, cohesive umbrella. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ptichka_500_500_px_250_x_250_px_2_635d8b5433.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BWAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

