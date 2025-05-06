module 0x70738f640ddabe78195ca9bb33b378d3d0c88086aa1a12b41479fc9de92d59f7::sdg {
    struct SDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDG>(arg0, 9, b"SDG", b"Sui Doge", b"Doge really very good", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/49b01ab3aaa21ec566f8f399bbc3daafblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

