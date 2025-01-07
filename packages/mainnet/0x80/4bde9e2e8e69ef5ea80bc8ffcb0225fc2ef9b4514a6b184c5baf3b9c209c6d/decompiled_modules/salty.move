module 0x804bde9e2e8e69ef5ea80bc8ffcb0225fc2ef9b4514a6b184c5baf3b9c209c6d::salty {
    struct SALTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALTY>(arg0, 6, b"Salty", b"Saltysui", b"The brighter you shine the darker your haters    ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5h4_GC_Kew_400x400_5083e580a7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SALTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

