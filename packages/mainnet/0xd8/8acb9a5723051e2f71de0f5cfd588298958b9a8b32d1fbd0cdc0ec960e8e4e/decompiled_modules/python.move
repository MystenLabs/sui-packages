module 0xd88acb9a5723051e2f71de0f5cfd588298958b9a8b32d1fbd0cdc0ec960e8e4e::python {
    struct PYTHON has drop {
        dummy_field: bool,
    }

    fun init(arg0: PYTHON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PYTHON>(arg0, 6, b"PYTHON", b"Chinese New Year Mascot", b"$PYTHON is the silent hunter of wealth, striking with precision in 2025, the Year of the Snake. This memecoin on SUI is ready to squeeze out weak hands and reward those who dare to hold$PYTHON is the silent hunter of wealth, striking with precision in 2025, the Year of the Snake. This memecoin on Solana is ready to squeeze out weak hands and reward those who dare to hold", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250129_132508_786_2e575d6634.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PYTHON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PYTHON>>(v1);
    }

    // decompiled from Move bytecode v6
}

