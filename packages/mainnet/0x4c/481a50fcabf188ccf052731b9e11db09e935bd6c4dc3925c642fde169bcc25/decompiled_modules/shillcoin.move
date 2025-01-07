module 0x4c481a50fcabf188ccf052731b9e11db09e935bd6c4dc3925c642fde169bcc25::shillcoin {
    struct SHILLCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHILLCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHILLCOIN>(arg0, 9, b"SHILLCOIN", b"Boss shill", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cf79f944-a581-467f-8095-d1124025a52a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHILLCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHILLCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

