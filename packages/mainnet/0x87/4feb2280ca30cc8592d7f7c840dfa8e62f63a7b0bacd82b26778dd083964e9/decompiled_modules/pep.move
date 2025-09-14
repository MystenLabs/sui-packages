module 0x874feb2280ca30cc8592d7f7c840dfa8e62f63a7b0bacd82b26778dd083964e9::pep {
    struct PEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEP>(arg0, 9, b"PEPECOIN", b"PEP", b"The first Pepecoin. Launched with the original web domain from 2015: pepecoin.ga | Website: https://pepecoin.ga/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/6C713wU.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

