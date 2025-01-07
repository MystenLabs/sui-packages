module 0x24df937fd38055254abe49ea2cc6337bae7abf07a27b0a755986b3eedc989fde::second {
    struct SECOND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SECOND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SECOND>(arg0, 9, b"SECOND", b"Time Farm", x"c490e1bbab6e67206cc3a36e67207068c3ad207468e1bb9d69206769616e2c2068c3a3792074e1baad6e2064e1bba56e672074e1bbab6e67206769c3a279202d206368e1baa16d2076c3a0206b69e1babf6d20242076e1bb9b692054696d65204661726d2063e1bba761206368c3ba6e672074c3b4692c206769e1bb9d20c491c3a27920c491c3a3207469e1bb876e206ce1bba369207472c3aa6e20c49169e1bb876e2074686fe1baa1692063e1bba7612062e1baa16e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/08deee22-1715-4e71-81b4-917d2617efea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SECOND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SECOND>>(v1);
    }

    // decompiled from Move bytecode v6
}

