module 0xdac4b513b7aad71bb5f7b7daad95234f0c748e007a44251baba832ed2066692b::gmmy {
    struct GMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMMY>(arg0, 6, b"Gmmy", b"Gommies", x"546f7563682067726173732c207468657920736169640a49742077696c6c2062652066756e2c207468657920736169642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fs9_HRL_a_UAA_6cz_H_276af7fb57.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GMMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

