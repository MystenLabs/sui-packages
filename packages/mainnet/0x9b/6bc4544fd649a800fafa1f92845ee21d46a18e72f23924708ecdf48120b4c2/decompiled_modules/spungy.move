module 0x9b6bc4544fd649a800fafa1f92845ee21d46a18e72f23924708ecdf48120b4c2::spungy {
    struct SPUNGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPUNGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPUNGY>(arg0, 6, b"SPUNGY", b"SPUNGY ON SUI", x"5350554e4759206973204c4946452c205350554e4759206973205355492e0a446f6e742061736b205748592c206a757374205249444520746865205350554e47592021", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logomovepump_e1f14141f0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPUNGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPUNGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

