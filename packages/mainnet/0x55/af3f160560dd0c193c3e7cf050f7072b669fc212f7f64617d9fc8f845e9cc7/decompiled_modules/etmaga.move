module 0x55af3f160560dd0c193c3e7cf050f7072b669fc212f7f64617d9fc8f845e9cc7::etmaga {
    struct ETMAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETMAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETMAGA>(arg0, 6, b"ETMAGA", b"ELON TRUMP MAGA", b"ELON TRUMP MAKE AMERICA GREAT AGAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_54071de1d6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETMAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ETMAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

