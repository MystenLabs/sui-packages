module 0x4860d84f59ad6850de2d4c5a4ccb44898492e375706053e6e53b9eebdda31e64::d {
    struct D has drop {
        dummy_field: bool,
    }

    fun init(arg0: D, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<D>(arg0, 9, b"D", b"BC", b"XCV", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f78f214a-bcd1-4242-a5ff-703fb3220ecc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<D>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<D>>(v1);
    }

    // decompiled from Move bytecode v6
}

