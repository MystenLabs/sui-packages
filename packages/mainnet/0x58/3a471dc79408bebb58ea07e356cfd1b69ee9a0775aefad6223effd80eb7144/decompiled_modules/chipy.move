module 0x583a471dc79408bebb58ea07e356cfd1b69ee9a0775aefad6223effd80eb7144::chipy {
    struct CHIPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIPY>(arg0, 6, b"CHIPY", b"CHIRPY", b"Join the flock and watch as $CHIPY makes its mark this season!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731434572941.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHIPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIPY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

