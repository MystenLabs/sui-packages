module 0x9fd0fc5f3b4fda2bdf9c5758da41052a81d371a71b50b623afccec930dbdd887::maid {
    struct MAID has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAID>(arg0, 9, b"MAID", b"Sea Marmaid", b"Marmaid sings charm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MAID>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAID>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAID>>(v1);
    }

    // decompiled from Move bytecode v6
}

