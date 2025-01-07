module 0xa4ee6d4e53165612826bb6000007999feffa3acc1e999a38ab6eedd6caf5b2d::big12shark {
    struct BIG12SHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIG12SHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIG12SHARK>(arg0, 9, b"BIG12SHARK", b"Aaanew", b"Nicely to start, LFG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/407bae61-b7c4-4675-a925-08337832b411.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIG12SHARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIG12SHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

