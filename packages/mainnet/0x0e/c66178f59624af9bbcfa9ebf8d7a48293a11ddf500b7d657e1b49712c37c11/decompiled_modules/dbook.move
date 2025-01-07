module 0xec66178f59624af9bbcfa9ebf8d7a48293a11ddf500b7d657e1b49712c37c11::dbook {
    struct DBOOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBOOK>(arg0, 6, b"DBOOK", b"DeepBook on Sui", b"Gm to those who still gm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_1_f4fd2c1018.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBOOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DBOOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

