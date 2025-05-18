module 0xb9050e32b09d8ce0646c2717725d35464f2a341bdfca8c0263dd8d44bc95831b::mmtg {
    struct MMTG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMTG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMTG>(arg0, 6, b"MMTG", b"MEMETHING", b"MEME FROM NOTHING TO SOMETHING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747555955782.PNG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMTG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMTG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

