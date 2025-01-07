module 0xdbbe68e1e62ec4541521eada3ab69bab78d89793c6805fbb0c964c717ebe84f3::dogskas {
    struct DOGSKAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGSKAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGSKAS>(arg0, 9, b"DOGSKAS", b"Wewe", b"Gi you my tu day not ting ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f4b8e97c-0935-4a3b-8836-027d80ecb4d2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGSKAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGSKAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

