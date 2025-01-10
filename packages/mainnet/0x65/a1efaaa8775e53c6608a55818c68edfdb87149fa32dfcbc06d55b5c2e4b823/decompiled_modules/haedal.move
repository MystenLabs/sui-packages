module 0x65a1efaaa8775e53c6608a55818c68edfdb87149fa32dfcbc06d55b5c2e4b823::haedal {
    struct HAEDAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAEDAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAEDAL>(arg0, 6, b"HAEDAL", b"Haedal", b"Haedal, Su blok zincirinin ynetiimine ve ademi merkeziyetiliine katkda bulunmak iin herkesin SUI belirtelerini paylamasna izin veren Su zerine ina edilmi likit bir bahis protokoldr.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2025_01_10_13_08_22_90d6682352.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAEDAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAEDAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

