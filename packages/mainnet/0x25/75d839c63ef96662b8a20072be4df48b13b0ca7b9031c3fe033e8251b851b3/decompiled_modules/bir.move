module 0x2575d839c63ef96662b8a20072be4df48b13b0ca7b9031c3fe033e8251b851b3::bir {
    struct BIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIR>(arg0, 6, b"BIR", b"Bitch I'm Rich", b"Bitch, I'm Rich", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732496564657.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

