module 0x8ba8e24a90480ce7e1994513f33003eec88b2c9416ab0161f8c16ce91400b92a::gbyte {
    struct GBYTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBYTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GBYTE>(arg0, 6, b"GBYTE", b"Gatorbyte", b"GatorByte: Fierce. Fun. Future-Forward.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000010146_a95002b8b2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBYTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GBYTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

