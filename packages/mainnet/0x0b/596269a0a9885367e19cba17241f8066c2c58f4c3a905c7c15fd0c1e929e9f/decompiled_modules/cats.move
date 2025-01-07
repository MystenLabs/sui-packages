module 0xb596269a0a9885367e19cba17241f8066c2c58f4c3a905c7c15fd0c1e929e9f::cats {
    struct CATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATS>(arg0, 9, b"CATS", b"Catwewe", b"Feelings for cats", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/44837362-efa5-42b4-8314-d5db240586ea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

