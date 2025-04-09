module 0x427fed2a625f37e9ade12e391c242ce491827749bacf05e4bc677aeedd3c61eb::blue {
    struct BLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUE>(arg0, 9, b"Blue", b"Blue Degen", b"This blue-skinned crypto degen lives life one cigar puff at a time. When he's not flexing his golden socks or sipping top-shelf whisky, he's checking charts with diamond hands and 2% battery.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5c21994977b73d3d58277afd8db60705blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

