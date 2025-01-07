module 0x8f30b529d38a6936583d493d6adb83ab5ba414cd592985dc67a2d7fc43f5b836::bibocoin {
    struct BIBOCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIBOCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIBOCOIN>(arg0, 9, b"BIBOCOIN", b"BiBo", x"426520696e207468652066757475726520627920627579696e67207468697320746f6b656e0a5468697320636f696e206d656d65206973206a75737420746f206d616b6520796f7520612062696c6c696f6e616972650a496e7375726520796f757273656c6620616e6420796f7572206368696c6472656e27732066757475726520627920627579696e6720736f6d65206f662074686973206d656d65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8971b414-a814-4317-9154-04de52f82a68.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIBOCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIBOCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

