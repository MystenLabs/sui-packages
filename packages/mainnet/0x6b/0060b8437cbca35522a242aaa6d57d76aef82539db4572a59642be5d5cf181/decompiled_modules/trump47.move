module 0x6b0060b8437cbca35522a242aaa6d57d76aef82539db4572a59642be5d5cf181::trump47 {
    struct TRUMP47 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP47, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP47>(arg0, 6, b"TRUMP47", b"Official Trump 47", b"Celebrating Trump as the 47th President of the United States", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737230215538.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP47>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP47>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

