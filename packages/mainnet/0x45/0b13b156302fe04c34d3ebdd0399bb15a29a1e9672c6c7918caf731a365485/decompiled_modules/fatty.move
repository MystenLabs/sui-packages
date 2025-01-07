module 0x450b13b156302fe04c34d3ebdd0399bb15a29a1e9672c6c7918caf731a365485::fatty {
    struct FATTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FATTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FATTY>(arg0, 9, b"FATTY", b"FAT BOY", b"Fattest Boy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FATTY>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FATTY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FATTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

