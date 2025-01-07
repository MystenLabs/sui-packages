module 0xd256addf999077cf81efaec1d90db504d2731d30bf93247fb336334c304ff4e2::bwhale {
    struct BWHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWHALE>(arg0, 6, b"BWHALE", b"BLUE WHALE", b"Influence the Meme world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_D7_F989_A_2_D2_C_4_F71_8086_FF_7651772239_5909ab2eda.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BWHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

