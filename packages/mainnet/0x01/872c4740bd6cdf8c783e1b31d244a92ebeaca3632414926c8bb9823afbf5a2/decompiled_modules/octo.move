module 0x1872c4740bd6cdf8c783e1b31d244a92ebeaca3632414926c8bb9823afbf5a2::octo {
    struct OCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTO>(arg0, 6, b"OCTO", x"4f7363617220546865204f63746f20f09f9099", b"Oscar was no ordinary octopus; he had a passion for decentralized finance and a dream of bringing the wonders of the blockchain to his underwater friends.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731937991743.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OCTO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

