module 0x1bfc1f4a41f35d752cecb55dece728e10f3cedbea1bd127a888d9ba5d8d6cda1::cheyenne {
    struct CHEYENNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEYENNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEYENNE>(arg0, 6, b"CHEYENNE", b"CHEYENNE ON SUI", b"FIRST CHEYENNE ON SUI : cheyenneonsui.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d4f8f4_1b159b67a81741eeb9d9d63b7f12ae05_mv2_2_1a714f572a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEYENNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEYENNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

