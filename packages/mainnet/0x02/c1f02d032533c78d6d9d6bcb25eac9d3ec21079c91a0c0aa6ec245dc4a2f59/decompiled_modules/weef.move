module 0x2c1f02d032533c78d6d9d6bcb25eac9d3ec21079c91a0c0aa6ec245dc4a2f59::weef {
    struct WEEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEEF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEEF>(arg0, 9, b"WEEF", b"Wolf", b"The best in hunting meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cc75ec62-75c9-424c-a1cf-1e44147c57ff.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEEF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEEF>>(v1);
    }

    // decompiled from Move bytecode v6
}

