module 0x34c46fd150699ab6801b63ebf7e9947ff39bc81412b7c17028bb392198611cb4::jinx {
    struct JINX has drop {
        dummy_field: bool,
    }

    fun init(arg0: JINX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JINX>(arg0, 6, b"JINX", b"JINX SUI", b"I am gonna blow your mind!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731898689339.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JINX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JINX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

