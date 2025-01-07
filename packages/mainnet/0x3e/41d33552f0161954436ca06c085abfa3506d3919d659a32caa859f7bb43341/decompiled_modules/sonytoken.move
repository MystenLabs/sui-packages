module 0x3e41d33552f0161954436ca06c085abfa3506d3919d659a32caa859f7bb43341::sonytoken {
    struct SONYTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONYTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONYTOKEN>(arg0, 9, b"SONYTOKEN", b"Sony", b"Token from Sony technologi for comunitas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c84aea77-fbaf-42b5-910d-700585a132ca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONYTOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SONYTOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

