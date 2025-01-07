module 0x1aac28ad0f95ce86f140fe0727cd48a2746d76d44a87fd3abf21a11e54ffd56e::wifheli {
    struct WIFHELI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFHELI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFHELI>(arg0, 6, b"WIFHELI", b"Dog Wif Helicopter Hat", b"new dog wif new hat, send it to millis.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0388_727586487f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFHELI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIFHELI>>(v1);
    }

    // decompiled from Move bytecode v6
}

