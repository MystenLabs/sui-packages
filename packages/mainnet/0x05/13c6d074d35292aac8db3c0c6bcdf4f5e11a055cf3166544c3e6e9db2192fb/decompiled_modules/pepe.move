module 0x513c6d074d35292aac8db3c0c6bcdf4f5e11a055cf3166544c3e6e9db2192fb::pepe {
    struct PEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPE>(arg0, 6, b"PEPE", b"INFANT PEPE", b"Pepe reincarnated? Say No More. Pepe is at 3.5B, Mini Pepe is here to take over from Pepe! Mini Pepe is here to take the crypto space by storm, be a part of the revolution!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/09_1024x1024_bd3623b926.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

