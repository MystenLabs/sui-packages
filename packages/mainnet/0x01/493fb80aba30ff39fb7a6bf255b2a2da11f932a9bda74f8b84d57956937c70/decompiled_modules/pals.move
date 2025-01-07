module 0x1493fb80aba30ff39fb7a6bf255b2a2da11f932a9bda74f8b84d57956937c70::pals {
    struct PALS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PALS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PALS>(arg0, 9, b"PALS", b"Pandapals", b"PandaPals is a meme token designed to bring together a worldwide community of panda lovers! With the vision of bringing joy and laughter to the crypto world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5421988b-b0f3-418c-bd52-2e0d72a92a4f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PALS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PALS>>(v1);
    }

    // decompiled from Move bytecode v6
}

