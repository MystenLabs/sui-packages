module 0xe69af7235a5b58300d92bde1757436f97e78cfab776a739f44f4ebc974209673::rufcoinsui {
    struct RUFCOINSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUFCOINSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUFCOINSUI>(arg0, 6, b"RufCoinSui", b"Ruf Coin Sui", x"486f7020696e746f2052756621200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_1_e247b20936.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUFCOINSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUFCOINSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

