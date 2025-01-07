module 0xd36e28732ed9ab8a3b99dc3e17f7d047d9646679d5d1dcf3b51a4be58567598::suin {
    struct SUIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIN>(arg0, 6, b"SUIN", b"Vladimir Suin", b"I'm gonna rocket Sui the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/putinrug22_25eabbecf2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

