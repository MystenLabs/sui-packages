module 0x8a314d4cd0c06907ecfd9de572f2eb00754463b99ad42a122d4bb57baceb63c0::bubba {
    struct BUBBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBBA>(arg0, 6, b"BUBBA", b"Bubba", x"427562612069732074686520627562626c69657374207365616c206f6620746865207365612c20686527732061206c6974746c652063686f6e6b2077686f206c6f766573206d616b696e6720612073706c6173682e0a486520697320616c7761797320757020666f7220616e20616476656e74757265207468617473207768792068652069732068657265206f6e2074686520535549206e6574776f726b2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_705de3c35c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

