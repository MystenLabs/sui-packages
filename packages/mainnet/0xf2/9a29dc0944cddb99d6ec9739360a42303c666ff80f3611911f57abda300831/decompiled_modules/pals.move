module 0xf29a29dc0944cddb99d6ec9739360a42303c666ff80f3611911f57abda300831::pals {
    struct PALS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PALS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PALS>(arg0, 9, b"PALS", b"Pandapals", b"PandaPals is a meme token designed to bring together a worldwide community of panda lovers! With the vision of bringing joy and laughter to the crypto world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7bf23aef-4928-4a96-87cc-867c99a18e0f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PALS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PALS>>(v1);
    }

    // decompiled from Move bytecode v6
}

