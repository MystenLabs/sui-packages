module 0x3f85cb8f1c5b733c1efc6993100d3962bf0358191904b87eba37c229d7d5de81::wifheli {
    struct WIFHELI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFHELI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFHELI>(arg0, 6, b"WIFHELI", b"Dog Wif Helicopter Hat", b"new dog wif new hat, send it to millis", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0388_3c479dc742.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFHELI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIFHELI>>(v1);
    }

    // decompiled from Move bytecode v6
}

