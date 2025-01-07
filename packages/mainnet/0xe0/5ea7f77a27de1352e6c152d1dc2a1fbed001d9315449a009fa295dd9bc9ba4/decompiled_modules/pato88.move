module 0xe05ea7f77a27de1352e6c152d1dc2a1fbed001d9315449a009fa295dd9bc9ba4::pato88 {
    struct PATO88 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PATO88, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PATO88>(arg0, 9, b"PATO88", b"Pato", b"World lively cat designs for peace all over the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f32bc914-6afc-4890-93a3-779ebc236615.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PATO88>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PATO88>>(v1);
    }

    // decompiled from Move bytecode v6
}

