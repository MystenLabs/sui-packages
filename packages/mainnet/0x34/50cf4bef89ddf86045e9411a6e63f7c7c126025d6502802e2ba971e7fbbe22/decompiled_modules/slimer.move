module 0x3450cf4bef89ddf86045e9411a6e63f7c7c126025d6502802e2ba971e7fbbe22::slimer {
    struct SLIMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLIMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLIMER>(arg0, 6, b"SLIMER", b"Sui Slimer", b"Slimer - One of the best things about Slimer is his unique and memorable personality. Hes a mischievous, lovable ghost with an insatiable appetite and a knack for causing chaos.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000013081_e5e887c1f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLIMER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLIMER>>(v1);
    }

    // decompiled from Move bytecode v6
}

