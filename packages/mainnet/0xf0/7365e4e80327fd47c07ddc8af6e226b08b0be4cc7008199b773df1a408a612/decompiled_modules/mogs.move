module 0xf07365e4e80327fd47c07ddc8af6e226b08b0be4cc7008199b773df1a408a612::mogs {
    struct MOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOGS>(arg0, 6, b"MOGS", b"MOGSUI", b"THE INTERNET'S FIRST CULTURE COIN ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xaaee1a9723aadb7afa2810263653a34ba2c21c7a_45c6f6817e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

