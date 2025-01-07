module 0x80fbda28829e5c8faf4205eafea7e5b7514e1ea0fdfcf391d8e9edbd0c2737e6::d343 {
    struct D343 has drop {
        dummy_field: bool,
    }

    fun init(arg0: D343, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<D343>(arg0, 6, b"D343", b"d", b"ferds dfada a dad adad ad ad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ghoul_796bad5995_bab64b1dd5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<D343>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<D343>>(v1);
    }

    // decompiled from Move bytecode v6
}

