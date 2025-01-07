module 0x9152de4c7b3ca43b95d246024817c26953bb408c44b3e1e0110b3e736cae32ad::trc20 {
    struct TRC20 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRC20, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRC20>(arg0, 9, b"TRC20", b"TRC2", b"The sui Tsunami enjoy the mem coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/22eeca2d-9c52-4d48-b6c2-5a9c1bf32a89.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRC20>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRC20>>(v1);
    }

    // decompiled from Move bytecode v6
}

