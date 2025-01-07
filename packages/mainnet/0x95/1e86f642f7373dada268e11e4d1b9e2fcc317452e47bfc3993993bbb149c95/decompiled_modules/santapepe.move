module 0x951e86f642f7373dada268e11e4d1b9e2fcc317452e47bfc3993993bbb149c95::santapepe {
    struct SANTAPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANTAPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANTAPEPE>(arg0, 6, b"Santapepe", b"Santapepe Coin On SUI", x"53616e7461205065706520697320736c6964696e6720646f776e20746865206368696d6e657920746f2074616b652068697320726967687466756c207468726f6e6520617320746865206d656d65206b696e67206f662063727970746f2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_santapepe_a5ad897a1b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANTAPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANTAPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

