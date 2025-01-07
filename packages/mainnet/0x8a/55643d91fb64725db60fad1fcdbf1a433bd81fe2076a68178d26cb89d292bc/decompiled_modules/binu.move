module 0x8a55643d91fb64725db60fad1fcdbf1a433bd81fe2076a68178d26cb89d292bc::binu {
    struct BINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BINU>(arg0, 6, b"Binu", b"Blub inu", x"4e455720737569206d656d65207472656e640a6920616d206120626c756220696e750a6c6667", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e_e_1_128f25e803.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

