module 0x28c94d66beda5677d2bfc24d5286cb350eac8918f1c9a77da29dffa82bb9884d::dopefish {
    struct DOPEFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOPEFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOPEFISH>(arg0, 6, b"Dopefish", b"Dopefish Sui", x"446f706520466973682c2042696720447265616d2e20526964696e6720746865207761766520696e746f20746865206e6578742067656e65726174696f6e206f66206d656d6520746f6b656e732e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Vro_Zhn5r_400x400_880ed6247c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOPEFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOPEFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

