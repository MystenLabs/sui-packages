module 0xe3bb727b198e59202b96748c8bdf41867fe1dfd7276f93263b97febc2255c99f::morti {
    struct MORTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORTI>(arg0, 6, b"MORTI", b"MORTI SUI", b"Morti the bear killer.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_D_D_D_D_N_D_N_D_D_D_35_1dba0597ea.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MORTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

