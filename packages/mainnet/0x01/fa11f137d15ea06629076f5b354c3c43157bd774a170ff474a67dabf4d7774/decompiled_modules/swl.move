module 0x1fa11f137d15ea06629076f5b354c3c43157bd774a170ff474a67dabf4d7774::swl {
    struct SWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWL>(arg0, 6, b"SWL", b"Suiwhale", b"Making everyone like a whale", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000333593_d13e7e348f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWL>>(v1);
    }

    // decompiled from Move bytecode v6
}

