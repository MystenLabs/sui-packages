module 0x4bcb845920e13772251695e7cbd284af0180235d7749ff0818ff31f236890b2c::eco {
    struct ECO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECO>(arg0, 6, b"ECO", b"EcoToken", b"A sustainable cryptocurrency that supports environmental initiatives and reduces carbon footprint", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/046b5d03_6281_11ee_95f4_318d05e0a674_f658679215.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ECO>>(v1);
    }

    // decompiled from Move bytecode v6
}

