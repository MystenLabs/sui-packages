module 0xe262c1b02e77224e696c2d92c32dd7e5c6422c383340480ed9ecadaece613c22::tmsc {
    struct TMSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMSC>(arg0, 9, b"TMSC", b"TOMASCAT", b"Memcoin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/75cd4591-8803-4b53-93eb-a47a6756e699-IMG_7358.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMSC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TMSC>>(v1);
    }

    // decompiled from Move bytecode v6
}

