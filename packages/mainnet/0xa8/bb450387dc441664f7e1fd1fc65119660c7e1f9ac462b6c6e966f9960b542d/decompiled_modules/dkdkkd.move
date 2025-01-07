module 0xa8bb450387dc441664f7e1fd1fc65119660c7e1f9ac462b6c6e966f9960b542d::dkdkkd {
    struct DKDKKD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DKDKKD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DKDKKD>(arg0, 9, b"DKDKKD", b"Ysjakal", b"Kvlvk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5d9574c0-ba57-41c8-b8b5-6ab53f6ffd2d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DKDKKD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DKDKKD>>(v1);
    }

    // decompiled from Move bytecode v6
}

