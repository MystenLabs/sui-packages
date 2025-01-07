module 0x9073d1f33ae89d022f61ceef51ed85f6fbe4385cdd44646f48dae86f22a03264::agx {
    struct AGX has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGX>(arg0, 9, b"AGX", b"Agapeonx", b"community driven ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8c7473ec-d306-4737-9b1b-aae0dd20e314.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGX>>(v1);
    }

    // decompiled from Move bytecode v6
}

