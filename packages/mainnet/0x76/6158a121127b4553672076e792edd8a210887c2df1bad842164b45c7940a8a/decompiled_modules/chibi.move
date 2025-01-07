module 0x766158a121127b4553672076e792edd8a210887c2df1bad842164b45c7940a8a::chibi {
    struct CHIBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIBI>(arg0, 6, b"Chibi", b"Neko no Chibi", b"Chibi in a blue kimono with serene expression represents guidance and wisdom.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_01_at_20_52_09_ee6f1362b6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

