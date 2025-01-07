module 0x3ace2fe73dddc82b1efa5caf0d0ba4366d6e8a163cc02ff856daf756df628f8a::xuxu {
    struct XUXU has drop {
        dummy_field: bool,
    }

    fun init(arg0: XUXU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XUXU>(arg0, 9, b"XUXU", b"gabriel", b"gabriel and xuxu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f9baf55b-8816-438a-bb11-265911a341be.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XUXU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XUXU>>(v1);
    }

    // decompiled from Move bytecode v6
}

