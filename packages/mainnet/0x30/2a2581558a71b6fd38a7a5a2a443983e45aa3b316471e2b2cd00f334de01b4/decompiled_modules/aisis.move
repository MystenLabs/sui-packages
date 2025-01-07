module 0x302a2581558a71b6fd38a7a5a2a443983e45aa3b316471e2b2cd00f334de01b4::aisis {
    struct AISIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AISIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AISIS>(arg0, 6, b"AIsis", b"Ankh", x"3130205052494e54202241497369733a2041492b416e6b683d4e656f6e467574757265220a323020474f544f2031300a606060e2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808be2808b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736108648495.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AISIS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AISIS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

