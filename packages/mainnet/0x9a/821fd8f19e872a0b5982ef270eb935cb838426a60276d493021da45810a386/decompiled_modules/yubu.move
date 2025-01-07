module 0x9a821fd8f19e872a0b5982ef270eb935cb838426a60276d493021da45810a386::yubu {
    struct YUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUBU>(arg0, 6, b"YUBU", b"Yubusui", b"A new hero has emerged, bearing the name Yubu.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ZORQ_Fm6_Y_400x400_603e4e9459.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUBU>>(v1);
    }

    // decompiled from Move bytecode v6
}

