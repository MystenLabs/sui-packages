module 0x8542b65b15898e792f521b0fe07638146d5ab4367000441aa8494409b7a734be::suintel {
    struct SUINTEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINTEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINTEL>(arg0, 6, b"SUINTEL", b"Suintel", x"57656c63756d20746f205375696e74656c20436f6f72652046616d756c790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_2024_10_10_T160842_303_3c487b2867.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINTEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINTEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

