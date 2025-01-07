module 0x9c80de134b2957ba98d140f73adcf59e0b201f860455105299a3fbc18b7e6c0e::suiwolf {
    struct SUIWOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWOLF>(arg0, 6, b"SUIWOLF", b"Sui Wolf", x"24535549574f4c46202d205468652069636f6e206f66205375692e2053756920576f6c6620697320746865206d6f737420446567656e6572617465206368617261637465722066726f6d20746865204d617474204675726965277320426f79277320636c756220636f6d69632e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_30_02_27_20_faeb241282.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWOLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWOLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

