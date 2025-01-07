module 0xa971f292bac4b967b9badbbb65553538e237ea206714e59f2fb4c6d8c46e4a52::anal {
    struct ANAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANAL>(arg0, 6, b"ANAL", b"ANALOS", b"GRAB YOUR $ANALOS AND MOONWALK TO THE MOON  IT'S THE ONLY WAY TO GO FORWARD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/28805_f6ecc9af60.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

