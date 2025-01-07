module 0xff45dae3e9816f74f6187a39836fe0ba576e8429da1d14370d0b06f11ad73d8a::blui {
    struct BLUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUI>(arg0, 6, b"BLUI", b"Blui on Sui", b"Blui on Sui is a playful and community-driven memecoin inspired by this generation's favorite blue pup, Bluey. Built on the innovative SUI blockchain, Blui aims to bring fun and financial freedom to its holders while celebrating the creativity of cry", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732339293861.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

