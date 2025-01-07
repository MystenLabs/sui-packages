module 0x4ccfef9e55ad8c67579b6797111c2379fa4bba3f3429d0bcb33480c56ec98a2a::stmbr {
    struct STMBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: STMBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STMBR>(arg0, 6, b"Stmbr", b"Suitember", b"September is the holy month of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1140_dc2dde53ac.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STMBR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STMBR>>(v1);
    }

    // decompiled from Move bytecode v6
}

