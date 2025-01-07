module 0x545e86355175a335a2db38ffb4af9f4fa004ce4112880205ef99b98cb0362c96::wtmlsui {
    struct WTMLSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTMLSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTMLSUI>(arg0, 6, b"Wtmlsui", b"Watermelon sui", b"Let's build a watermelon colony on Mars. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1001173439_f42086a9a2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTMLSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WTMLSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

