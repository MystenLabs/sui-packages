module 0x3ffc75aee084cb29964cc8851a0fdd51a082206040a5628da74575ea268bfb6::falmata {
    struct FALMATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FALMATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FALMATA>(arg0, 9, b"FALMATA", b"RIERIE", b"RIERIE is a nickname of someone girlfriend inspired by him and took it personal to drive it on wave Blockchain to prove the existance of love and care.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f5f05ee7-af7f-4eb5-a96a-c13c7048af2a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FALMATA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FALMATA>>(v1);
    }

    // decompiled from Move bytecode v6
}

