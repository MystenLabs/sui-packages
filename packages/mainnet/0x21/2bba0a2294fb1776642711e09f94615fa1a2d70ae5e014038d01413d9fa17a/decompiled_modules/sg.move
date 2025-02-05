module 0x212bba0a2294fb1776642711e09f94615fa1a2d70ae5e014038d01413d9fa17a::sg {
    struct SG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SG>(arg0, 6, b"SG", b"Suigoat", b"The goat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1690_5c61cbd929.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SG>>(v1);
    }

    // decompiled from Move bytecode v6
}

