module 0xe286dfa2682a328680290cb2249529c46b509720f8de3b5c1afc622a2b99da20::doge123 {
    struct DOGE123 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE123, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE123>(arg0, 9, b"DOGE123", b"dogememe", x"63686f206cc3a020636f6e206d656d65206465206e756f69206e6861", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/04d92015-40b1-41cf-a7fe-8e014734a1da.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE123>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGE123>>(v1);
    }

    // decompiled from Move bytecode v6
}

