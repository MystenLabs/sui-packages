module 0xf2caf4f9a3435a0ac93a194c2d0118c98a6c04880a81dc31338800e7dcce6e16::magacto {
    struct MAGACTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGACTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGACTO>(arg0, 6, b"MAGACTO", b"MAGASUICTO", x"4d4147412046554e20544f4b454e204f4e205355490a46554c4c2043544f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/trump_MAGA_739839237_3aaa68acce.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGACTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGACTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

