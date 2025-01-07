module 0x350cbb0a6a8faff03fd774807e6aba8553270f6c883fcc8b7bdbf8cbe051db68::suikong {
    struct SUIKONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKONG>(arg0, 6, b"SUIKONG", b"Sui KONG", b"The king of the Sui jungle. Bigger, stronger, and ready to smash anything in his path.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wukong_1_1743cc3beb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

