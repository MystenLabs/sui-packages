module 0x318b6b608697cefc96ff80adf0c1f530eebb14d4fefa50d7eb22b665ce852d1a::t25 {
    struct T25 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T25, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T25>(arg0, 9, b"T25", b"Trumpmeme2", b"T25 may rock in 2025", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f7f2e309-bf88-4c4f-bd8e-6353beca956c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T25>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T25>>(v1);
    }

    // decompiled from Move bytecode v6
}

