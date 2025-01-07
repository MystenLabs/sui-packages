module 0x39ab434dbba5e1bf25b73d1ba08ad7bcfd318bc41a71db47b3f6f2caa929e5bd::skt {
    struct SKT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKT>(arg0, 9, b"SKT", b"Stupid Cat", b"Meet the epitome of feline foolishness! Our White Stupid Cat token represents the hilarious moments of absurdity and silliness that only a clueless kitty can provide.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c9627764-52e8-4e56-bac2-23c1990b686d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKT>>(v1);
    }

    // decompiled from Move bytecode v6
}

