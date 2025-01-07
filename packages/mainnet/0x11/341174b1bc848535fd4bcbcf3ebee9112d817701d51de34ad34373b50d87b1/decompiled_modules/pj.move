module 0x11341174b1bc848535fd4bcbcf3ebee9112d817701d51de34ad34373b50d87b1::pj {
    struct PJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PJ>(arg0, 9, b"PJ", b"PJ10", b"One potential token that will change alot of lives", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/35483be9-e112-4166-b731-fa396d218ea9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

