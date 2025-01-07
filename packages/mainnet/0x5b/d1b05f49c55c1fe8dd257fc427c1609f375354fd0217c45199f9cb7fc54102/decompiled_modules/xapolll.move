module 0x5bd1b05f49c55c1fe8dd257fc427c1609f375354fd0217c45199f9cb7fc54102::xapolll {
    struct XAPOLLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: XAPOLLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XAPOLLL>(arg0, 9, b"XAPOLLL", b"xapolll", b"Xapolll is a new meme token that aims to unite the meme and cryptocurrency community. The token's symbol is a smiling emoji :) and its motto is \"Harosh is good!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2c0c3d9e-979c-479f-9178-d85d2bdcb43a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XAPOLLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XAPOLLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

