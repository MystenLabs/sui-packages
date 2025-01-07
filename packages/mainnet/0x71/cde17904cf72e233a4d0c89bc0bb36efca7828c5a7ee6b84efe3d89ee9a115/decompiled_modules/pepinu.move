module 0x71cde17904cf72e233a4d0c89bc0bb36efca7828c5a7ee6b84efe3d89ee9a115::pepinu {
    struct PEPINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPINU>(arg0, 6, b"PEPINU", b"Pepe Inu", b"Pepe Inu is a groundbreaking memecoin on the Sui blockchain, designed to build a strong, active, and engaged community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241130_204059_940c479085.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

