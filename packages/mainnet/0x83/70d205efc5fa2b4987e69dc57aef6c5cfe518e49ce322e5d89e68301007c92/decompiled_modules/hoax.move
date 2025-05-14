module 0x8370d205efc5fa2b4987e69dc57aef6c5cfe518e49ce322e5d89e68301007c92::hoax {
    struct HOAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOAX>(arg0, 6, b"Hoax", b"the climate hoax", b"The ultimate climate hoax coin for the truth seekers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiahjzsymf3zcjug2aaytuxjbn6lnt7cvfbuiuh267ll3ceri7irty")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HOAX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

