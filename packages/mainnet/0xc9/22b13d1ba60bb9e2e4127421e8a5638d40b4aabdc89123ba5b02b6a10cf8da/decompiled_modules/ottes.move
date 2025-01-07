module 0xc922b13d1ba60bb9e2e4127421e8a5638d40b4aabdc89123ba5b02b6a10cf8da::ottes {
    struct OTTES has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTTES>(arg0, 6, b"OTTES", b"OTTES ON SUI", b"The lightning-fast otter of the Sui waters! With sleek moves and boundless energy, $OTTES is here to bring the thrill of the chase to the Sui network. Dive in and ride the waves with this agile, unstoppable otter as it swims straight toward success!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OTTIER_7bf3575da3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTTES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OTTES>>(v1);
    }

    // decompiled from Move bytecode v6
}

