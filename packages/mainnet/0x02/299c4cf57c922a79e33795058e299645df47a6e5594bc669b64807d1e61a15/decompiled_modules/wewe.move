module 0x2299c4cf57c922a79e33795058e299645df47a6e5594bc669b64807d1e61a15::wewe {
    struct WEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWE>(arg0, 9, b"WEWE", b" WEWE", b"WEWEWEWE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5a54b490-fc54-4ec1-a542-24dfaf75affd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

