module 0xf352f7819bf2d61806a1a5a50e0edff544ef6411dcfcdada8f5c90688f32b845::dlcc {
    struct DLCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DLCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DLCC>(arg0, 9, b"DLCC", b"My DLCC Token", b"My DLCC Token for Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/3377082/Fuzzing-Dicts/master/Somd5%20Dictionary/SONG.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DLCC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DLCC>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun mint_to_address(arg0: u64, arg1: &mut 0x2::coin::TreasuryCap<DLCC>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DLCC>>(0x2::coin::mint<DLCC>(arg1, arg0, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

