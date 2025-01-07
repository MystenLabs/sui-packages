module 0x131ed720cdd5e275095005b904cbf0059d29181464409c3a984bd9ccc831b6a::beeg {
    struct BEEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEEG>(arg0, 6, b"BEEG", b"Beeg Blue Whale", b"Innovation will never end. Just grab some $BEEG, come to the community and enjoy it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_WX_3_Ni_He_400x400_be1bb9e1c4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEEG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEEG>>(v1);
    }

    // decompiled from Move bytecode v6
}

