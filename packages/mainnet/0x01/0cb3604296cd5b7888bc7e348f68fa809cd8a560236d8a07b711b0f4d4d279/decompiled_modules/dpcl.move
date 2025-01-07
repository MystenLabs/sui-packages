module 0x10cb3604296cd5b7888bc7e348f68fa809cd8a560236d8a07b711b0f4d4d279::dpcl {
    struct DPCL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DPCL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DPCL>(arg0, 9, b"DPCL", b"DPC", b"DPC (Dynamic Payment Coin) is a meme token designed to simplify bill payments, enabling users to pay utilities, subscriptions, and services with cryptocurrency. With low fees, fast transactions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/30192300-f597-402d-b370-e2daf86ba066.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DPCL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DPCL>>(v1);
    }

    // decompiled from Move bytecode v6
}

