module 0x7e42dff2eac9e70e59e277ca13c4396669e913ef5404371c9be97199a3f942e3::pals {
    struct PALS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PALS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PALS>(arg0, 9, b"PALS", b"Pandapals", b"PandaPals is a meme token designed to bring together a worldwide community of panda lovers! With the vision of bringing joy and laughter to the crypto world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/33a58614-81c3-4dd1-9174-1bafd51d08c7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PALS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PALS>>(v1);
    }

    // decompiled from Move bytecode v6
}

