module 0xbc4ec3a1beaa71357e8cb49e71064aa49da7b38b960a981abfb97d99e126d9da::loh {
    struct LOH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOH>(arg0, 6, b"BRK", b"Baracuda", b"Baracuda token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/N_N_D_D_N_D_N_D_d1b423d435.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOH>>(v1);
    }

    // decompiled from Move bytecode v6
}

