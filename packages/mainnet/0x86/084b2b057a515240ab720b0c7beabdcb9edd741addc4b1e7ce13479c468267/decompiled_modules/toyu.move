module 0x86084b2b057a515240ab720b0c7beabdcb9edd741addc4b1e7ce13479c468267::toyu {
    struct TOYU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOYU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOYU>(arg0, 9, b"TOYU", b"Ty", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9665710f-c541-4469-984d-80689fa26181.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOYU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOYU>>(v1);
    }

    // decompiled from Move bytecode v6
}

