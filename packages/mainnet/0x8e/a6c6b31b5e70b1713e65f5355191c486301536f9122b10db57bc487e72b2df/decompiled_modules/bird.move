module 0x8ea6c6b31b5e70b1713e65f5355191c486301536f9122b10db57bc487e72b2df::bird {
    struct BIRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRD>(arg0, 6, b"BIRD", b"bird", b"just a bird", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c_e_0f9b542ff7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

