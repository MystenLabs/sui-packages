module 0x6458ff5811ddbb898e519126fd10929379c695110d797d7abf8ef9de404e4708::cic {
    struct CIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIC>(arg0, 9, b"CIC", b"GIA", b"The world is for digital currency So invest wisely Together! Because \"GIA\" will be a part of it!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/255e0f1b-ad33-444a-8b42-75133e579164-1000504028.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

