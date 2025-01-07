module 0x73f3c94802f59ca36ba737bf54c247f9612125871ac90065bf059c88c733496f::nonam3 {
    struct NONAM3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NONAM3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NONAM3>(arg0, 9, b"NONAM3", b"Noname", b"Nonam3 noname", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7329f094-7f99-49d1-b402-343c65d36817.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NONAM3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NONAM3>>(v1);
    }

    // decompiled from Move bytecode v6
}

