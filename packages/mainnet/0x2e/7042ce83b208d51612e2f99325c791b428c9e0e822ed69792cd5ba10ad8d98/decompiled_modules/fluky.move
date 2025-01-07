module 0x2e7042ce83b208d51612e2f99325c791b428c9e0e822ed69792cd5ba10ad8d98::fluky {
    struct FLUKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUKY>(arg0, 9, b"FLUKY", b"We Lucky's", b"A cryptocurrency whose images are based on memes from the Internet. This is a digital asset that exists only on the Internet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b3eef049-bb5d-40b4-9968-15156251f635.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLUKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

