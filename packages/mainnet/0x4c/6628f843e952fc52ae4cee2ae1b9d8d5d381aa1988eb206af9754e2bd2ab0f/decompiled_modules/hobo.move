module 0x4c6628f843e952fc52ae4cee2ae1b9d8d5d381aa1988eb206af9754e2bd2ab0f::hobo {
    struct HOBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOBO>(arg0, 6, b"HOBO", b"hobo", b"Im a homeless man who has lost everything, his job, driving licence, my home, my woman and daughter, just made this token to reflect my situation thanks xx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/silverhobotoken250pixels_ad0ac7fbed.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

