module 0x3bd3a025a881b7afca80bdf12ddb0d4b7e25c77c5b9afd1fed829576c08e1a3::suina {
    struct SUINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINA>(arg0, 9, b"SUINA", b"Suina Dog", b"Suina First Girl Dog on Sui   https://suinadog.xyz https://x.com/SuinaonSui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1729184408059-f5d94f891c946bb9556a82a876924c61.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUINA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINA>>(v1);
    }

    // decompiled from Move bytecode v6
}

