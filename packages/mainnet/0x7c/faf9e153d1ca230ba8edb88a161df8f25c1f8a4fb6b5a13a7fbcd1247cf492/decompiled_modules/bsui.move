module 0x7cfaf9e153d1ca230ba8edb88a161df8f25c1f8a4fb6b5a13a7fbcd1247cf492::bsui {
    struct BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSUI>(arg0, 6, b"BSUI", b"Bittern Sui", x"54686520657261206f66204269747465726e2068617320636f6d6520746f2053756920616e642074686572652077696c6c2062652061206269672062616e6720686572650a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_02_23_14_25_f3d5529156.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

