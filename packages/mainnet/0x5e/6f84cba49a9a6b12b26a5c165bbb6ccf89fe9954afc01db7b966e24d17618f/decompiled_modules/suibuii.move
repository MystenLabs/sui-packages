module 0x5e6f84cba49a9a6b12b26a5c165bbb6ccf89fe9954afc01db7b966e24d17618f::suibuii {
    struct SUIBUII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBUII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBUII>(arg0, 6, b"SUIBUII", b"Sui BuII", x"2442756c6c27697368206f6e20746865200a405375694e6574776f726b0a20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Bu_II_fa25f295b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBUII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBUII>>(v1);
    }

    // decompiled from Move bytecode v6
}

