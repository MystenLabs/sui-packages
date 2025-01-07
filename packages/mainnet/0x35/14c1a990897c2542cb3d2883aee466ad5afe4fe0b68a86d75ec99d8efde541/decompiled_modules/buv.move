module 0x3514c1a990897c2542cb3d2883aee466ad5afe4fe0b68a86d75ec99d8efde541::buv {
    struct BUV has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUV>(arg0, 9, b"BUV", b"Buvy", b"Bull power", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1e472a17-1271-498f-9f89-b01c3d21258d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUV>>(v1);
    }

    // decompiled from Move bytecode v6
}

