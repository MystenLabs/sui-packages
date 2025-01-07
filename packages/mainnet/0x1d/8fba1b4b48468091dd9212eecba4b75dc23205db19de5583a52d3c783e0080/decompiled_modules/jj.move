module 0x1d8fba1b4b48468091dd9212eecba4b75dc23205db19de5583a52d3c783e0080::jj {
    struct JJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: JJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JJ>(arg0, 9, b"JJ", b"Jojo", b"Fun token jojo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/17c6f457-f6e0-4a29-9071-b0c873067afc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

