module 0x7712b01772b14fd473b58372dd3781f7a59414f0a793a3d4617afad98fcfe692::liu888 {
    struct LIU888 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIU888, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIU888>(arg0, 9, b"LIU888", b"XXX", b"rsghfbfbbfbfb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d63a10eb-ae30-489f-a13b-52d83b8f1d2c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIU888>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIU888>>(v1);
    }

    // decompiled from Move bytecode v6
}

