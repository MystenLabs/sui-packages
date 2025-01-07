module 0x130104a8c97ea1e5e13f2255fe6cdd7c3d280079575748dad6092ef4de355a29::byo {
    struct BYO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BYO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BYO>(arg0, 9, b"BYO", b"Boyyoo", b"For fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0743d288-aa8f-4794-a882-33a4da0b072f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BYO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BYO>>(v1);
    }

    // decompiled from Move bytecode v6
}

