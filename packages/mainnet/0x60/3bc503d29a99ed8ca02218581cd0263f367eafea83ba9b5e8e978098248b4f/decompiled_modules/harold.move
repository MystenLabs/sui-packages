module 0x603bc503d29a99ed8ca02218581cd0263f367eafea83ba9b5e8e978098248b4f::harold {
    struct HAROLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAROLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAROLD>(arg0, 6, b"HAROLD", b"HAROLD crab on sui", b"$HAROLD  the hermit crab of sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Db_Kjuvf_400x400_49f664c9fc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAROLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAROLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

