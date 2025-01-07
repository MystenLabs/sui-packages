module 0xfdb54aaa5882cc8b5774af18883bf38bb053c642723d3e44d5f86e204dabea7::gek {
    struct GEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEK>(arg0, 9, b"GEK", b"Geeks", b"Noob to moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b55e8945-23fa-4d04-ac90-08eb77740ce9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

