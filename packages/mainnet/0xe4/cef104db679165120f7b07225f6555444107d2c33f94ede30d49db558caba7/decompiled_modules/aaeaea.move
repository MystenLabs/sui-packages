module 0xe4cef104db679165120f7b07225f6555444107d2c33f94ede30d49db558caba7::aaeaea {
    struct AAEAEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAEAEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAEAEA>(arg0, 6, b"Aaeaea", b"aeae", b"aeaea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/we_ar_elive_wislun_eef0e97186.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAEAEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAEAEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

