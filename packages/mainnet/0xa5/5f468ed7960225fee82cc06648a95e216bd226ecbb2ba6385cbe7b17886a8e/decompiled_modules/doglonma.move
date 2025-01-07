module 0xa55f468ed7960225fee82cc06648a95e216bd226ecbb2ba6385cbe7b17886a8e::doglonma {
    struct DOGLONMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGLONMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGLONMA>(arg0, 9, b"DOGLONMA", b"Lonmadog", b"Dumadogslumma", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c04ed339-b8a8-40c6-b0d5-d85b6986f1e4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGLONMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGLONMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

