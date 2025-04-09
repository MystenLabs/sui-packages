module 0x47b7404547e98f2bbf3a48ee51d8a59218f525831e09caa69ffbf073c361ffa5::blue {
    struct BLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUE>(arg0, 9, b"Blue", b"Blue Degen", b"This blue-skinned crypto degen lives life one cigar puff at a time. When he's not flexing his golden socks or sipping top-shelf whisky, he's checking charts with diamond hands and 2% battery.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8e8ac4b2c07101a7ee2edf441fa5b602blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

