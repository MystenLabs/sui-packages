module 0x5f479b79006d614a1c7db673e551e3a25b64a77638200d52ab70f72a788d9ada::mog {
    struct MOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOG>(arg0, 9, b"MOG", b"Motion Dog", b"The Dog has got suift motion.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/68e3ba96-9e68-4fd6-91a3-5a66afc8d279.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

