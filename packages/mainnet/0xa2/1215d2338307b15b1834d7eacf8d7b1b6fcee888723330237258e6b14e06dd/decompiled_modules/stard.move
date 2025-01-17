module 0xa21215d2338307b15b1834d7eacf8d7b1b6fcee888723330237258e6b14e06dd::stard {
    struct STARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARD>(arg0, 6, b"STARD", b"Suitardio", x"22596f752063616e2062652052656563682e20596f752063616e2062652053756974617264696f22200a2d53756974617264696f2032303235", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008512_45eb851bb8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

