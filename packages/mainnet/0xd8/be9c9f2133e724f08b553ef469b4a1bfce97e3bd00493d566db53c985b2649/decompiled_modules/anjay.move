module 0xd8be9c9f2133e724f08b553ef469b4a1bfce97e3bd00493d566db53c985b2649::anjay {
    struct ANJAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANJAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANJAY>(arg0, 9, b"ANJAY", b"AENJEAYE", b"Start crazy time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/70bc6fdb-7948-4b75-ab86-0a4551e33579.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANJAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANJAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

