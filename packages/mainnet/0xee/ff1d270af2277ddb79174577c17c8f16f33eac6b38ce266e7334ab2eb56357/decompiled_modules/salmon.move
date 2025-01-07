module 0xeeff1d270af2277ddb79174577c17c8f16f33eac6b38ce266e7334ab2eb56357::salmon {
    struct SALMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALMON>(arg0, 6, b"SALMON", b"SillySalmon", b"The splashiest meme token on the SUI network!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000039147_efcf1571ac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SALMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

