module 0x6b0526d13f22c34c626b8ea9a62504d577356bf800aec3d55e73a8a767d0193b::dudu {
    struct DUDU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUDU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUDU>(arg0, 6, b"DUDU", b"DUDUDU", b"RUN IT DUDU !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihsza3pe63w75eagdfbmdivsufj23gcpiigeutgu2mloh36g7ypli")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUDU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DUDU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

