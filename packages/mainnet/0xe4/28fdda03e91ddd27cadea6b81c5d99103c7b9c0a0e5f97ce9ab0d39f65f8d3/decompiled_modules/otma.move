module 0xe428fdda03e91ddd27cadea6b81c5d99103c7b9c0a0e5f97ce9ab0d39f65f8d3::otma {
    struct OTMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTMA>(arg0, 9, b"OTMA", b"Otmanabuba", b"OTMA token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5190b2b4-a414-413a-a088-75ea149c4909.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OTMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

