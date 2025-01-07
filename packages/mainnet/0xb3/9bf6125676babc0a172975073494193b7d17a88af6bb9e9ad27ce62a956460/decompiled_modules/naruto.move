module 0xb39bf6125676babc0a172975073494193b7d17a88af6bb9e9ad27ce62a956460::naruto {
    struct NARUTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NARUTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NARUTO>(arg0, 9, b"NARUTO", b"NANA", b"NOTHING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e6264d53-3e33-4f53-b274-bbe435b3d0a5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NARUTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NARUTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

