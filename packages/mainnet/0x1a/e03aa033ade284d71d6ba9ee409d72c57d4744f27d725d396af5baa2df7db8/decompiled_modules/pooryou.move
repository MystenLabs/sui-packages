module 0x1ae03aa033ade284d71d6ba9ee409d72c57d4744f27d725d396af5baa2df7db8::pooryou {
    struct POORYOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: POORYOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POORYOU>(arg0, 9, b"POORYOU", b"Bearpoor", b"STFU PLAN A PLAN B if a bearish we poor", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aed5549e-4ef1-4021-b3f1-704ee8ac2ba3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POORYOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POORYOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

