module 0x18dd401f6ed895ad63fb41b59ee69e9f942952508a585bd08ca10bcf62989ccc::berawe {
    struct BERAWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BERAWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BERAWE>(arg0, 9, b"BERAWE", b"berawe", b"Berawe is the best meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/88e2725c-02d6-4eb8-93a2-9250a649a1ac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BERAWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BERAWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

