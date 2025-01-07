module 0x2f55e33fba5f9550915166cce241f70e17476c2a3de0025e3289e6228f65c518::pill {
    struct PILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PILL>(arg0, 6, b"Pill", b"Pill Popping Penguin", x"7069657272652c2073756920706172747920616e696d616c0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_Izl_P_Pw_P_400x400_546829b0c8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

