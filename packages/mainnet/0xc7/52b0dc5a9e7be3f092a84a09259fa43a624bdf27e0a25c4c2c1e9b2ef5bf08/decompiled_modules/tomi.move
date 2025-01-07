module 0xc752b0dc5a9e7be3f092a84a09259fa43a624bdf27e0a25c4c2c1e9b2ef5bf08::tomi {
    struct TOMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOMI>(arg0, 9, b"TOMI", b"Tom", b"Tomi is the best cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9252a0fa-e867-4063-96ee-cfa7e89acc0d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

