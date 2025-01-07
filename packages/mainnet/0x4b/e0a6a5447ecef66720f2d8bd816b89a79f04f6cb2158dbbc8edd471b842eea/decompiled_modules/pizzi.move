module 0x4be0a6a5447ecef66720f2d8bd816b89a79f04f6cb2158dbbc8edd471b842eea::pizzi {
    struct PIZZI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIZZI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIZZI>(arg0, 6, b"PIZZI", b"Sui Pizzi", b"Pizi is the first pizza memecoin on the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000015969_b7b0d2fdba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIZZI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIZZI>>(v1);
    }

    // decompiled from Move bytecode v6
}

