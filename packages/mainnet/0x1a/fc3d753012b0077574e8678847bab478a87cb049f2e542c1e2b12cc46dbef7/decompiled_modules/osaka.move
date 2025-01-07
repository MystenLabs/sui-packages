module 0x1afc3d753012b0077574e8678847bab478a87cb049f2e542c1e2b12cc46dbef7::osaka {
    struct OSAKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAKA>(arg0, 6, b"Osaka", b"Osaka Protocol", b"Where true decentralization is born again. $OSAK ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOG_Ooaska_978d953ba3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OSAKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

