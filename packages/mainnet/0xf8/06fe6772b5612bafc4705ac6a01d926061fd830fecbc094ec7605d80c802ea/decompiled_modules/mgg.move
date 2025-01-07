module 0xf806fe6772b5612bafc4705ac6a01d926061fd830fecbc094ec7605d80c802ea::mgg {
    struct MGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MGG>(arg0, 6, b"Mgg", b"Memez.gg", b"something is cooking ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/n8_KMWY_6_400x400_322545fb8c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

