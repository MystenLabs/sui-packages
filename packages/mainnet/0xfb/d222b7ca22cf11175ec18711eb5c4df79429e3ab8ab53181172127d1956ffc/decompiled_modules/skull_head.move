module 0xfbd222b7ca22cf11175ec18711eb5c4df79429e3ab8ab53181172127d1956ffc::skull_head {
    struct SKULL_HEAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKULL_HEAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKULL_HEAD>(arg0, 9, b"SKULL_HEAD", b"PB", b"The game is theoretical but the fun is real ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/db7298d9-565f-45e9-b583-33e782621ce4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKULL_HEAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKULL_HEAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

