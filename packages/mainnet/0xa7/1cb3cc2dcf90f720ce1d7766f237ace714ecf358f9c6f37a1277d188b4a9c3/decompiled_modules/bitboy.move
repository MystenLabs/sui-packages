module 0xa71cb3cc2dcf90f720ce1d7766f237ace714ecf358f9c6f37a1277d188b4a9c3::bitboy {
    struct BITBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITBOY>(arg0, 6, b"BitBoy", b"BitBoy on SUI", b"BitBoySE: Play, Earn, Mine, Repeat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1x5_FX_0_Hf_400x400_1_175a8b8c75.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITBOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITBOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

