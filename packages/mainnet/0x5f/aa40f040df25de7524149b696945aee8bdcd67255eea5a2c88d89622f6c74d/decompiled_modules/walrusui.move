module 0x5faa40f040df25de7524149b696945aee8bdcd67255eea5a2c88d89622f6c74d::walrusui {
    struct WALRUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALRUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALRUSUI>(arg0, 6, b"WALRUSUI", b"Walrus Dog", b"Walrus dog on sui is making waves though the network ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/91249102eas_854b6b9e8e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALRUSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WALRUSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

