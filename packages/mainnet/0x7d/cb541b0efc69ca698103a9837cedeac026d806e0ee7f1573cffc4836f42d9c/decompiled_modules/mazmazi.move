module 0x7dcb541b0efc69ca698103a9837cedeac026d806e0ee7f1573cffc4836f42d9c::mazmazi {
    struct MAZMAZI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAZMAZI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAZMAZI>(arg0, 9, b"MAZMAZI", b"Mazmaz", b"Little nice meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/91360bc9-80b5-4113-802f-db220f8c82a2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAZMAZI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAZMAZI>>(v1);
    }

    // decompiled from Move bytecode v6
}

