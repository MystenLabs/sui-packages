module 0x2b6b0f964c5c41653cbda8ddc9f592623e4833a0cb3264c6ef5702705f3234af::ptg {
    struct PTG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTG>(arg0, 9, b"PTG", b"Puffthedra", b"My first meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/76bdcc07-7c02-4915-a318-4452d0e19f15.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTG>>(v1);
    }

    // decompiled from Move bytecode v6
}

