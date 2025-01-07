module 0x887ca1ee30051de6e8631f30af89e0a987e9e5c3e78fe9152dd273b79779a2c2::goose {
    struct GOOSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOSE>(arg0, 6, b"GOOSE", b"SUI GOOSE", x"5468652053554945535420474f4f5345204f4e20535549210a436f6d65206a6f696e207468652053554920474f4f534520434c414e0a2a2a2a2a484f4e4b20484f4e4b2a2a2a2a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f1642e76_d8d5_476c_b89b_d98c096a3d88_725d12c059.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

