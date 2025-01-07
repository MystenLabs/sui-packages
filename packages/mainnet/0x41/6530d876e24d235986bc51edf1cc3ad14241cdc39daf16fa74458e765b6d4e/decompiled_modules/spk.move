module 0x416530d876e24d235986bc51edf1cc3ad14241cdc39daf16fa74458e765b6d4e::spk {
    struct SPK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPK>(arg0, 9, b"SPK", b"StickPicK", b"Let's Pick the Stick and Make Our Wealth Great Again. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4d706829-8a21-4a97-88f8-5ca7c8c463b8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPK>>(v1);
    }

    // decompiled from Move bytecode v6
}

