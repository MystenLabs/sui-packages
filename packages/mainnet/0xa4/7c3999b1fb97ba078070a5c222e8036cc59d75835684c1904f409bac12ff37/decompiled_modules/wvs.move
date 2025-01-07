module 0xa47c3999b1fb97ba078070a5c222e8036cc59d75835684c1904f409bac12ff37::wvs {
    struct WVS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WVS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WVS>(arg0, 9, b"WVS", b"WAVES", b"Ocean tokens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f7398c74-330c-41ea-8479-3b7bbae816c4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WVS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WVS>>(v1);
    }

    // decompiled from Move bytecode v6
}

