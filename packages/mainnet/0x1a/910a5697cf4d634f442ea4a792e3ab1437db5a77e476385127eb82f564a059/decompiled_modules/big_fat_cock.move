module 0x1a910a5697cf4d634f442ea4a792e3ab1437db5a77e476385127eb82f564a059::big_fat_cock {
    struct BIG_FAT_COCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIG_FAT_COCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIG_FAT_COCK>(arg0, 9, b"BIG FAT COCK", b"BIG FAT COCK", b"BIGGEST FATTEST COCK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BIG_FAT_COCK>(&mut v2, 3000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIG_FAT_COCK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIG_FAT_COCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

