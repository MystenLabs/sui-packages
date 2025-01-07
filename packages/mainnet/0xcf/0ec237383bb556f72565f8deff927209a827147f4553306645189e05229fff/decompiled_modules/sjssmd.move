module 0xcf0ec237383bb556f72565f8deff927209a827147f4553306645189e05229fff::sjssmd {
    struct SJSSMD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SJSSMD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SJSSMD>(arg0, 9, b"SJSSMD", b"Wuwjwn", b"Xjcmmcmc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b1bae1a5-cc91-4ee3-8504-1e1c147ad806.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SJSSMD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SJSSMD>>(v1);
    }

    // decompiled from Move bytecode v6
}

