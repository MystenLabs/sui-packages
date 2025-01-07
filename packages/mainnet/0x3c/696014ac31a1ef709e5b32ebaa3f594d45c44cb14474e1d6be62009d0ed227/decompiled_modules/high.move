module 0x3c696014ac31a1ef709e5b32ebaa3f594d45c44cb14474e1d6be62009d0ed227::high {
    struct HIGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIGH>(arg0, 6, b"HIGH", b"HIGHER", b"HIGHER FOR SUI AND HIGHER FOR HIGHER!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4wp6l5_688810bfbe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

