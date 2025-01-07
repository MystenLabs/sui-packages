module 0xad1da7c26ba8eee321d07e54c933bb5c73593e3e333afbb8a382d8468a1d3e1a::casuino {
    struct CASUINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CASUINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CASUINO>(arg0, 6, b"CaSUIno", b"CaSUIno on Sui", b"Te first CASINO on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CASUINO_3b0e52a35d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CASUINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CASUINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

