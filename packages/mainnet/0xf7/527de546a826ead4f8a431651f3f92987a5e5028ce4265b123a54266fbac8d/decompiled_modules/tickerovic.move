module 0xf7527de546a826ead4f8a431651f3f92987a5e5028ce4265b123a54266fbac8d::tickerovic {
    struct TICKEROVIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICKEROVIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TICKEROVIC>(arg0, 9, b"TICKEROVIC", b"Testov", b"Descriptor", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/42d38c58-1666-498d-a486-70ebc0c657b3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TICKEROVIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TICKEROVIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

