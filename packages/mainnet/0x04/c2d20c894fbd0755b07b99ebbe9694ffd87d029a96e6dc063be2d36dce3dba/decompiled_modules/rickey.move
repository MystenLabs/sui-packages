module 0x4c2d20c894fbd0755b07b99ebbe9694ffd87d029a96e6dc063be2d36dce3dba::rickey {
    struct RICKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICKEY>(arg0, 6, b"RICKEY", b"First Rickey On Sui", b"Hey there, Im Rickey, the raccoon with BIG dreams!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_23_56aa5ed040.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RICKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

