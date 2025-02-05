module 0x25c57b8325eebfd902bc5a96ec55877dea1f0243b13d23aeb258f20d2782c222::tru {
    struct TRU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRU>(arg0, 9, b"TRU", b"Trump", b"This is trump coin on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/33607138-9791-4db6-8f7f-7e47d0c9f777.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRU>>(v1);
    }

    // decompiled from Move bytecode v6
}

