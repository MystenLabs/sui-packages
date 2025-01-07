module 0xccae668a71e5603777fac6aefb26c24c644ddd931d0e77ee47a9e6e993756250::popcorn {
    struct POPCORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPCORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPCORN>(arg0, 9, b"POPCORN", b"Crunchy", b"Wow na wow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d10653d3-c4a6-4471-a12a-3a21fd5f193a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPCORN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPCORN>>(v1);
    }

    // decompiled from Move bytecode v6
}

