module 0x94043d8d4a34b88184768b23877b9c9d36edd81228a48a9371eaade473b9fd83::ssn {
    struct SSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSN>(arg0, 6, b"SSN", b"SUISANA", b"The first cute mermaid on the sui blockchain with mythical powers and Princess of the ocean. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8508_02ab598c7c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSN>>(v1);
    }

    // decompiled from Move bytecode v6
}

