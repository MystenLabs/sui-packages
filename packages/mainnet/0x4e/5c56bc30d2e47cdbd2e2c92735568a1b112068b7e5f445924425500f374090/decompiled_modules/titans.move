module 0x4e5c56bc30d2e47cdbd2e2c92735568a1b112068b7e5f445924425500f374090::titans {
    struct TITANS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TITANS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TITANS>(arg0, 6, b"TITANS", b"TITANS OF SUI", b"Titans of SUI | Armored in strength, united in vision. Defenders of innovation and builders of a new meme meta", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736181912049.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TITANS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TITANS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

