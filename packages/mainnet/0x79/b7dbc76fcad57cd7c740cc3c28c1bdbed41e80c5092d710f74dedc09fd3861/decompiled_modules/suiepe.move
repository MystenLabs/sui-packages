module 0x79b7dbc76fcad57cd7c740cc3c28c1bdbed41e80c5092d710f74dedc09fd3861::suiepe {
    struct SUIEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIEPE>(arg0, 6, b"SUIEPE", b"Sui Raindrop", b"SUIEPE: The Mascot of the SUI Chain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b8m_Id_Mz_U_400x400_78e5790a16.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

