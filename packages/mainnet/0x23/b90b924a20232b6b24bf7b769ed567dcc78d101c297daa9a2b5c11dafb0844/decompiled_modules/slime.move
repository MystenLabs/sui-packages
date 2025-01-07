module 0x23b90b924a20232b6b24bf7b769ed567dcc78d101c297daa9a2b5c11dafb0844::slime {
    struct SLIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLIME>(arg0, 6, b"SLIME", b"suislime", b"The first cute formless monster on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/P_Io_E_Yf_BU_400x400_d7b9c4e31f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLIME>>(v1);
    }

    // decompiled from Move bytecode v6
}

