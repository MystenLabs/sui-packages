module 0xe993eeaabfba3f4faa427a8b628dd80aecc6a9574a4042c3eccd91dde9d1a95f::merro {
    struct MERRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MERRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MERRO>(arg0, 6, b"Merro", b"Merro On Sui", b"merro spreading the green gospel of memes while unearthing the juiciest opportunities in the market with Ai ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aptg_In_Y3_400x400_e920f25833.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MERRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MERRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

