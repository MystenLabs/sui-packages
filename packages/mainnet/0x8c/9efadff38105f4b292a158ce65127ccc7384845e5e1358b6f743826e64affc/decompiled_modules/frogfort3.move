module 0x8c9efadff38105f4b292a158ce65127ccc7384845e5e1358b6f743826e64affc::frogfort3 {
    struct FROGFORT3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGFORT3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGFORT3>(arg0, 9, b"FROGFORT3", b"Blac cvadr", b"Coinndex", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/53ebc23f-395d-4ad2-8141-17cf59478cec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGFORT3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FROGFORT3>>(v1);
    }

    // decompiled from Move bytecode v6
}

