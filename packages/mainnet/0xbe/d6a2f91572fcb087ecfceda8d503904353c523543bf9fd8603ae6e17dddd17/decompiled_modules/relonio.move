module 0xbed6a2f91572fcb087ecfceda8d503904353c523543bf9fd8603ae6e17dddd17::relonio {
    struct RELONIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RELONIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RELONIO>(arg0, 6, b"RELONIO", b"RELONIO MUSK", b"Relonio is the CEO of X, Tesla, and the next generation of SUI tokens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_05_17_124533_7785062b86.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RELONIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RELONIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

