module 0xc04a0d9dcbcc129699afb61e8277dd32ad9b360feecaadfe41fc6d2facda1ca3::pengsui {
    struct PENGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGSUI>(arg0, 9, b"PENGSUI", b"PENGSU OFFICIAL", b"The first cross-eyed penguin on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1af1c39773789522e29aa48521f79d3cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENGSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

