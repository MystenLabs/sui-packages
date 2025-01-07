module 0x93b215226f93f14d833c395b4b6a5fa9f756d071352933b7640a6a0d7b42daea::suispicious {
    struct SUISPICIOUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISPICIOUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISPICIOUS>(arg0, 6, b"SUISPICIOUS", b"Suispicious", b"Join the most SUS coin on SUI! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Usi_2_cc3497aa9b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISPICIOUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISPICIOUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

