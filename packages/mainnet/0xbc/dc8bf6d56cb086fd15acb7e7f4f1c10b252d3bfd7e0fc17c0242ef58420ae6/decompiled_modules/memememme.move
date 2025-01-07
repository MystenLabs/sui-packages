module 0xbcdc8bf6d56cb086fd15acb7e7f4f1c10b252d3bfd7e0fc17c0242ef58420ae6::memememme {
    struct MEMEMEMME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEMEMME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEMEMME>(arg0, 9, b"MEMEMEMME", b"Bhao", b"It's dogs plus cats combination ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7e9b0006-4981-4f67-befe-9ab433d84e0a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEMEMME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEMEMME>>(v1);
    }

    // decompiled from Move bytecode v6
}

