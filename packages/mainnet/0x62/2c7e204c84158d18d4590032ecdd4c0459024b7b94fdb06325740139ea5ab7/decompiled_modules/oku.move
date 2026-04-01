module 0x622c7e204c84158d18d4590032ecdd4c0459024b7b94fdb06325740139ea5ab7::oku {
    struct OKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: OKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OKU>(arg0, 6, b"OKU", b"OKUSANA", b"OKUSANA is a global, community-driven Web3 platform that empowers users to create, share, and monetize content without borders. The OKU token is used for rewards, content support, and decentralized governance, enabling a fair and transparent ecosyste", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1775073866472.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OKU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OKU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

