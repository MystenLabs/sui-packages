module 0x1ab70d9698da1edb79a0bc5582ef07b998dbea75e61c471371619bfcd9da92de::foryou {
    struct FORYOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORYOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORYOU>(arg0, 9, b"FORYOU", b"Apocalypse", b"Safe the World ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d8b0cfc7-485b-4ee5-893b-13166c0ca468.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORYOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FORYOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

