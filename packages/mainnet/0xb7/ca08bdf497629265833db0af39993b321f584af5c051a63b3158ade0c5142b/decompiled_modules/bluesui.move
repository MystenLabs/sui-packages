module 0xb7ca08bdf497629265833db0af39993b321f584af5c051a63b3158ade0c5142b::bluesui {
    struct BLUESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUESUI>(arg0, 6, b"BlueSui", b"BSui", b"t.me/BlueSuiPortal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ibb.co/23K9kYd"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUESUI>>(v1);
        0x2::coin::mint_and_transfer<BLUESUI>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BLUESUI>>(v2);
    }

    // decompiled from Move bytecode v6
}

