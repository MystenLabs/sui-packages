module 0xefdeb957435e43f19e549746d9060ace8b4cedd5f9d94e852fef7bd3045657df::trident {
    struct TRIDENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRIDENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRIDENT>(arg0, 6, b"TRIDENT", b"Ruler of Seas", x"4f6e652054524944454e5420746f2072756c6520616c6c206f66205355492e0a546865206d696768746965737420776561706f6e206f662074686520536576656e20536561732068617320726973656e20746f207361766520616c6c20736f756c73206f6620746865206f6365616e20636861696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730951179887.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRIDENT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRIDENT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

