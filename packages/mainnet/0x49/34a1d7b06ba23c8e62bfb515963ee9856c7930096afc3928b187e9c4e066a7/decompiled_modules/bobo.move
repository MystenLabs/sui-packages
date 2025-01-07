module 0x4934a1d7b06ba23c8e62bfb515963ee9856c7930096afc3928b187e9c4e066a7::bobo {
    struct BOBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBO>(arg0, 9, b"BOBO", b"BOBO", b"The Bobar", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOBO>(&mut v2, 9990000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

