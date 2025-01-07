module 0x2e7178e97771e7db56587e97290da8d5119f867639c32e878df974aeb46a8b7f::pepeblinders {
    struct PEPEBLINDERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEBLINDERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEBLINDERS>(arg0, 6, b"PEPEBLINDERS", b"PEPE BLINDERS ON SUI", b"Introducing Pepe Blinders, the suave and stylish memecoin that combines the charm of a blue Pepe with the cool, calculated confidence of a Peaky Blinders gangster. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/peakypepe_e7c5a36c70.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEBLINDERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEBLINDERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

