module 0x2e373a1848b6ef5117bc660bac0190ac58dec604332ab655bd1688cd2f665c11::bna {
    struct BNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNA>(arg0, 9, b"BNA", b"benana", b"Great token for athletes and very useful and fantastic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7753a2be-c75c-44e9-9221-60ddc4708eac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

