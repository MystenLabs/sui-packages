module 0x7d6f945c3a00fb4fb83b5667c9ea0f60e5c068124799c29219557af62cfdaecd::murr {
    struct MURR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MURR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MURR>(arg0, 9, b"MURR", b"Murrka", b"Murka the cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f8e347b8-561c-45b7-95de-7c6263c85f28.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MURR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MURR>>(v1);
    }

    // decompiled from Move bytecode v6
}

