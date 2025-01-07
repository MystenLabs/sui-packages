module 0x6660f8288da385ea3d33d6ee61062c9a25fcebc19a32ffa525ce432c6339687f::broy {
    struct BROY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROY>(arg0, 9, b"BROY", b"Bang Roy", b"\"Bang Roy\" Token is determine how the respect he is.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c9b4fc4f-77d3-4faf-bd0f-2126e19f2ada.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BROY>>(v1);
    }

    // decompiled from Move bytecode v6
}

