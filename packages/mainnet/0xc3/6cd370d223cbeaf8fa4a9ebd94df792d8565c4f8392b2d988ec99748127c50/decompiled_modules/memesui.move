module 0xc36cd370d223cbeaf8fa4a9ebd94df792d8565c4f8392b2d988ec99748127c50::memesui {
    struct MEMESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMESUI>(arg0, 9, b"MEMESUI", b"Memefi sui", b"Memefi in sui platform.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d422e381-c37d-438c-9575-7470d8a4d001.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

