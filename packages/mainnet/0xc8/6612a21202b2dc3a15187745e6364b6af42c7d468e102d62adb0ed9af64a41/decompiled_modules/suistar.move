module 0xc86612a21202b2dc3a15187745e6364b6af42c7d468e102d62adb0ed9af64a41::suistar {
    struct SUISTAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISTAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISTAR>(arg0, 6, b"SUISTAR", b"SUI STAR FISH", x"412073746172666973682077616e646572696e6720696e20746865207365612c20616672616964206f66206265696e6720656174656e2062792062696720666973682e200a68747470733a2f2f742e6d652f7374617266697368737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1634_aa4d6bcd5e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISTAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISTAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

