module 0x4c451b136bad9dfd3398bdb655231edd8ac3fece77ef8f252961164656bacaa8::katsui {
    struct KATSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KATSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KATSUI>(arg0, 2, b"KATSU", b"Katsui", b"Katsu Katsu, nyaaaa.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ibb.co/m9ScFkY")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KATSUI>>(v1);
        0x2::coin::mint_and_transfer<KATSUI>(&mut v2, 25000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KATSUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

