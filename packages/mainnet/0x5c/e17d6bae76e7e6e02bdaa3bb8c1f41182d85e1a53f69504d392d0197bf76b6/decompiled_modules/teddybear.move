module 0x5ce17d6bae76e7e6e02bdaa3bb8c1f41182d85e1a53f69504d392d0197bf76b6::teddybear {
    struct TEDDYBEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEDDYBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEDDYBEAR>(arg0, 6, b"TEDDYBEAR", b"BEAR", b"$BEAR WITH US ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/o_SREF_7xx_400x400_676a7e3303.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEDDYBEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEDDYBEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

