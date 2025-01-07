module 0x4d5dcdbbf111051ac3e3bdc2efeafa818464417b67bc9dff9b652f0ec14ac657::kumo {
    struct KUMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUMO>(arg0, 6, b"KUMO", b"Kumo", b"This is a meme managed by the Kumo fan community!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1a_fa4507e2de.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

