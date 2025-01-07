module 0x2647d7a71c14fbf58e0ce997b4b024cd57ad5967712dc56fb1cf59ff335b9c6e::suikoko {
    struct SUIKOKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKOKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKOKO>(arg0, 6, b"SUIKOKO", b"SuiKoKo Sui", b"Koko the Chimp where the memes are minted and laughter thrives on SUI Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Ko_Ko_Sui_4102cc867e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKOKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKOKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

