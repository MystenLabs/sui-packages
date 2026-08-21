module 0x9049fd276322a20f844ac5ab1af7e05875efd17fa5e0dd1fba9ab00543b439a7::hHASUI {
    struct HHASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHASUI>(arg0, 9, b"hHASUI", b"hHASUI Coin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lv-curator.haedal.xyz/Lendvault/lpt/hhasui_909e741a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HHASUI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHASUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

