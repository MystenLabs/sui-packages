module 0xc4eb93de02d7b8b774f89ce094c0ebfd86b8c6b1a168445976a98f5778ba35ae::minnn {
    struct MINNN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINNN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINNN>(arg0, 9, b"MINNN", b"Minnnana", b"Amaaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/78088475-5bc3-46da-bce7-4fc06de21b65.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINNN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINNN>>(v1);
    }

    // decompiled from Move bytecode v6
}

