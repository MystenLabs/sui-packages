module 0x8272ea4ffe2f0401a445a94a0eaea362a659efef2a49e08423374f775ed7c170::dogie {
    struct DOGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGIE>(arg0, 6, b"DOGIE", b"Sui Dogie", b"Dogie is a dog that sticks its long tongue forward, very wet mucus makes the opposite sex aroused ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055929_39fb7b80a5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

