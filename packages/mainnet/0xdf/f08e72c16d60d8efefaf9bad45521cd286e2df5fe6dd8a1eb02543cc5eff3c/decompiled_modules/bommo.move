module 0xdff08e72c16d60d8efefaf9bad45521cd286e2df5fe6dd8a1eb02543cc5eff3c::bommo {
    struct BOMMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOMMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOMMO>(arg0, 6, b"BOMMO", b"Bommo", b"Bommo is the cutest creature of Sui, created by an Artist", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t_A_N_Uwd_C_400x400_80d1902031.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOMMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOMMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

