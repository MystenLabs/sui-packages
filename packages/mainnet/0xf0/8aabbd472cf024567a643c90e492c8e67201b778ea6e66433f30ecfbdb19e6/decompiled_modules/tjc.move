module 0xf08aabbd472cf024567a643c90e492c8e67201b778ea6e66433f30ecfbdb19e6::tjc {
    struct TJC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TJC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TJC>(arg0, 9, b"TJC", b"TAJCOIN", b"TOURISME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/740467dd815ca9fd5895bb64a64b2ce3blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TJC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TJC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

