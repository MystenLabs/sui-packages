module 0x8911bf3c424312647222275fdc04930bcf077ec0a65d23bd50f4017049902e87::skx {
    struct SKX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKX>(arg0, 9, b"SKX", b"Spending ", b"If I was in a relationship t", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/733081d0-1f83-45ac-9661-f53c0b15d7df.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKX>>(v1);
    }

    // decompiled from Move bytecode v6
}

