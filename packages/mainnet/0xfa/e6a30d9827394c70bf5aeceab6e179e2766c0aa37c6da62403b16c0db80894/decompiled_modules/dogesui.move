module 0xfae6a30d9827394c70bf5aeceab6e179e2766c0aa37c6da62403b16c0db80894::dogesui {
    struct DOGESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGESUI>(arg0, 9, b"DOGESUI", b"Doge sui t", b"Doge crypto in sui platform.good luck.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a5651ef1-1d4f-48c3-905b-6bb00a0d6292.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

