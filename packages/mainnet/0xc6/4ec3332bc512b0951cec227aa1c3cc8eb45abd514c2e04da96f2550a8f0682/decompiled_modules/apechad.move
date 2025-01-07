module 0xc64ec3332bc512b0951cec227aa1c3cc8eb45abd514c2e04da96f2550a8f0682::apechad {
    struct APECHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: APECHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APECHAD>(arg0, 6, b"APECHAD", b"APECHAD on Sui", b"Chad Ape", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/flat_750x_075_f_pad_750x1000_f8f8f8_0f30f09544.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APECHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APECHAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

