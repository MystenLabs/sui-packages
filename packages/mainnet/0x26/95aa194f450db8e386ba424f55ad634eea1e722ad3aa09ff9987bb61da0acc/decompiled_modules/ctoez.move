module 0x2695aa194f450db8e386ba424f55ad634eea1e722ad3aa09ff9987bb61da0acc::ctoez {
    struct CTOEZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTOEZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTOEZ>(arg0, 6, b"CTOEZ", b"CTO from start", b"CTO!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/y_H3v09m_d_83e2f0f3e4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTOEZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTOEZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

