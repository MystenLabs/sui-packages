module 0xde98bfee1ab913f1bb0594879ccbad9695e24d5f732a2271a3704e6780d550c4::first {
    struct FIRST has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIRST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIRST>(arg0, 6, b"FIRST", b"First Project", b" The very first project on Turbos.Fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730947034529.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIRST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIRST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

