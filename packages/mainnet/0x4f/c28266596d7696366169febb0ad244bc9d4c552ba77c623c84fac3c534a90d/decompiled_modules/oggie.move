module 0x4fc28266596d7696366169febb0ad244bc9d4c552ba77c623c84fac3c534a90d::oggie {
    struct OGGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGGIE>(arg0, 9, b"OGGIE", b"Oggie", x"f09d939cf09d93aaf09d93bdf09d93bd20f09d9395f09d93bef09d93bbf09d93b2f09d93ae20637265617465642074686520706f70756c61722050455045205468652046726f67206275742064696420796f75206b6e6f7720746861742074686520696e737069726174696f6e2063616d652066726f6d20616e206f6c6420636f6d696320626f6f6b2063616c6c656420224269672059756d2059756d20426f6f6b2220666561747572696e67205468652053746f7279206f66204f6767696520616e6420746865204265616e7374616c6b2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x11a001dc777f5bf8a5d63f246664d3bb67be496c.png?size=xl&key=339af6")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OGGIE>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGGIE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OGGIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

