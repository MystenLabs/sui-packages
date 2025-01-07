module 0x15e014d1fdb39474d3d6eeb7331d6220f268cb0afc9d6dacf273cec921abe9af::bll {
    struct BLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLL>(arg0, 9, b"BLL", b"bullet", b"Fast and high", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/222d8f79-b815-411c-846a-364c9b0d6c6c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

