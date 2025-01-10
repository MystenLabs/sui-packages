module 0x7d1540f0dfa8c40ce9f5511d169df840202fc4ddee75a686da89921b58daaa6c::shaqi {
    struct SHAQI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAQI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAQI>(arg0, 6, b"SHAQI", b"Shaqi", b"$SHAQI Sippin on coffe all days is what we do", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000023355_d06f2dc44a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAQI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHAQI>>(v1);
    }

    // decompiled from Move bytecode v6
}

