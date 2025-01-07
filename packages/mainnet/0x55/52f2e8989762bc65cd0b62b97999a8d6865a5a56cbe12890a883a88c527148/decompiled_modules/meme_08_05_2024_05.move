module 0x5552f2e8989762bc65cd0b62b97999a8d6865a5a56cbe12890a883a88c527148::meme_08_05_2024_05 {
    struct MEME_08_05_2024_05 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME_08_05_2024_05, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME_08_05_2024_05>(arg0, 6, b"MEME_08_05_2024_05", b"meme0805202405", b"08 May 2024 fifth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEME_08_05_2024_05>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME_08_05_2024_05>>(v2, @0x9636ead2159f25e1f269223d53d51f0065915a5255fecab0ff1485ab8c64eeec);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEME_08_05_2024_05>>(v1);
    }

    // decompiled from Move bytecode v6
}

