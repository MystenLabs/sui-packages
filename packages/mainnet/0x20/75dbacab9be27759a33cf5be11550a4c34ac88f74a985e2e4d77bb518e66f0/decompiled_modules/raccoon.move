module 0x2075dbacab9be27759a33cf5be11550a4c34ac88f74a985e2e4d77bb518e66f0::raccoon {
    struct RACCOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: RACCOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RACCOON>(arg0, 6, b"RACCOON", b"Sui Raccoon", b"Swift and clever Raccoon on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_raccoon_8b42aa00df.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RACCOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RACCOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

