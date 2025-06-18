module 0x1ff4257822ebb6ef9f0ae857ce735d9b4bcfea26e80af07747200598d339e56a::tt18 {
    struct TT18 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT18, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TT18>(arg0, 6, b"TT18", b"Test 18/6 - 10:30", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/staging/tokens/fbebfe16-6918-48b6-9f0b-44cdc19e4aca.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TT18>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TT18>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TT18>>(v1);
    }

    // decompiled from Move bytecode v6
}

