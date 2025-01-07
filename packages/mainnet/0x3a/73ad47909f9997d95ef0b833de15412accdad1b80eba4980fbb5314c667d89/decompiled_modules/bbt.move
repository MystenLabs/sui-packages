module 0x3a73ad47909f9997d95ef0b833de15412accdad1b80eba4980fbb5314c667d89::bbt {
    struct BBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBT>(arg0, 9, b"BBT", b"Bebtoken", b"Bebtoken is going to be the next time to make wave in the crypto space, watch out for it cause it's going to change the narrative about meme coins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f93004a5-a8e2-4701-89cc-30f16929c6f1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBT>>(v1);
    }

    // decompiled from Move bytecode v6
}

