module 0x3bc616b9ec1aef270a8dbcd758f1100eb5436184b4b5757f63d88a19eb0919c1::moa {
    struct MOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOA>(arg0, 9, b"MOA", b"Moai", b"It's just a rock ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/94b485fb-4751-4a4e-8de2-3dd8579cc749.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOA>>(v1);
    }

    // decompiled from Move bytecode v6
}

