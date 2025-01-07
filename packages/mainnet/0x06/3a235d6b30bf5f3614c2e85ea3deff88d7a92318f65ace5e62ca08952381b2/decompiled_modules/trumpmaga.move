module 0x63a235d6b30bf5f3614c2e85ea3deff88d7a92318f65ace5e62ca08952381b2::trumpmaga {
    struct TRUMPMAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPMAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPMAGA>(arg0, 6, b"TRUMPMAGA", b"MAGA SUI", b"TRUMP FOR PRESIDENT $TRUMPMAGA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4066_9750133018.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPMAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPMAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

