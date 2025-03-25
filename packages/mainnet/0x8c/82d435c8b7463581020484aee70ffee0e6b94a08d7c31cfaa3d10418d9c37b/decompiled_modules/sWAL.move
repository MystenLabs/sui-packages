module 0x8c82d435c8b7463581020484aee70ffee0e6b94a08d7c31cfaa3d10418d9c37b::sWAL {
    struct SWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWAL>(arg0, 6, b"sysWAL", b"SY sWAL", b"SY scallop sWAL", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

