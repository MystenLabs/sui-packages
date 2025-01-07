module 0xc794c3020bd8c10572da4c33bcbb70537a20facb98c36f7eed5b2abbc9b48a5c::simple2788 {
    struct SIMPLE2788 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMPLE2788, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMPLE2788>(arg0, 9, b"SIMPLE2788", b"Choice", b"My choice", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/46dad46d-f7dd-456d-be83-cf64a4caae29.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMPLE2788>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIMPLE2788>>(v1);
    }

    // decompiled from Move bytecode v6
}

