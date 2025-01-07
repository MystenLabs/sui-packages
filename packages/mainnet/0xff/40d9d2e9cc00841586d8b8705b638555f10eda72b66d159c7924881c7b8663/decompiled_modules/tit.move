module 0xff40d9d2e9cc00841586d8b8705b638555f10eda72b66d159c7924881c7b8663::tit {
    struct TIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIT>(arg0, 9, b"TIT", b"Titan", b"Tit token for wewe project ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0a904e64-ca03-4155-9b08-05b97e00179a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

