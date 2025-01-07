module 0xe4897d50d3ab59f8b5928392d61f45db7e5e623f077b14981b3c048c1f3acfe::hedg {
    struct HEDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEDG>(arg0, 9, b"HEDG", b"hedgehog", b"a cute hedgehog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b15df34f-0b76-4244-ad69-2e02f0c86c6b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

