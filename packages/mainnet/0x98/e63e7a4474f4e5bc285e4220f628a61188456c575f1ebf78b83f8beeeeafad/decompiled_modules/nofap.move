module 0x98e63e7a4474f4e5bc285e4220f628a61188456c575f1ebf78b83f8beeeeafad::nofap {
    struct NOFAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOFAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOFAP>(arg0, 6, b"NOFAP", b"first no fap on sui", b"first no fap on sui.Join now: https://nofaponsui.wtf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logofap_e5c9203f33.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOFAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOFAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

