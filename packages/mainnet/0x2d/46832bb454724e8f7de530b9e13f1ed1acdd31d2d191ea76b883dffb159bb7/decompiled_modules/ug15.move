module 0x2d46832bb454724e8f7de530b9e13f1ed1acdd31d2d191ea76b883dffb159bb7::ug15 {
    struct UG15 has drop {
        dummy_field: bool,
    }

    fun init(arg0: UG15, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UG15>(arg0, 9, b"UG15", b"Kanju", b"The main purpose is to get the low fee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/59a43a81-8efe-4c09-8651-0a4759ce0c4f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UG15>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UG15>>(v1);
    }

    // decompiled from Move bytecode v6
}

