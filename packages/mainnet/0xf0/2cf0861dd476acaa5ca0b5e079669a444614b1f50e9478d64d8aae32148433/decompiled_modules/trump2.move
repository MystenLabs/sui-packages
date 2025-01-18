module 0xf02cf0861dd476acaa5ca0b5e079669a444614b1f50e9478d64d8aae32148433::trump2 {
    struct TRUMP2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP2>(arg0, 9, b"TRUMP2", b"Official Trump 2.0", b"Missed the Official Trump? Here's your second chance!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmcc8dFKahPUDHk1aFSK3i7Nkz2W2ah8aujKVSN6r3rMiT")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRUMP2>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP2>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

