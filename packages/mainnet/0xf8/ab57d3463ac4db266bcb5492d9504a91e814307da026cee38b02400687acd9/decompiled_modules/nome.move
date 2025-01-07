module 0xf8ab57d3463ac4db266bcb5492d9504a91e814307da026cee38b02400687acd9::nome {
    struct NOME has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOME>(arg0, 9, b"NOME", b"NOTMEME", x"4d656574204e4f544d454d45212046756e6b696573742066726f6720696e2063727970746f212042494720445245414d53206f6620726963686e65737320262068756d6f722e0a4e4f544d454d4520436f696e3a0a2d20313030252046756e6b790a2d2048756d6f722d496e667573656420426c6f636b636861696e0a2d20526962626974696e6720526577617264730a2d2042696720447265616d732c20426967676572204761696e730a546f74616c20537570706c793a2046756e2042696c6c696f6e204e4f4d450a4a6f696e20526962626974696e67205265766f6c7574696f6e2122", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7fccf331-8495-403c-b5bb-bf13841e34c4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOME>>(v1);
    }

    // decompiled from Move bytecode v6
}

