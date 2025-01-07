module 0x5f21a4856baf121be73b6b519ccbc65a611fe97fbddb3ec621015ac30fbb189f::nfty {
    struct NFTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NFTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NFTY>(arg0, 9, b"NFTY", b"nfty", x"42c3b9692053e1bb8b74", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b6012b3a-8be4-4bc9-9938-c36c35802803.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NFTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NFTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

