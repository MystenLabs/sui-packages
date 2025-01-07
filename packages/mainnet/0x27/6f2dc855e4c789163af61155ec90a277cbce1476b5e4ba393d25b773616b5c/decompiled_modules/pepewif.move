module 0x276f2dc855e4c789163af61155ec90a277cbce1476b5e4ba393d25b773616b5c::pepewif {
    struct PEPEWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEWIF>(arg0, 6, b"PEPEWIF", b"Pepewifhat on SUI", b"This is the official pepewifhat. Its Pepe wif a hat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/o4_P7a_Zs_G_400x400_a4e22ce204.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

