module 0x20788fdca2f4117deebdccb0ac972dbf8c0906d71b1c2f944e107afdaaf5195f::fatpengu {
    struct FATPENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FATPENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FATPENGU>(arg0, 9, b"FATPENGU", b"FatPengu on SUI", b"If Pengu can become the biggest memecoin on Sui, imagine the chaos when Pengu turns FAT! $FATPENGU is here to take over!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmbf6oMB5RX1Ld8GZzjqiudBFfYFUjkx4J7mSDz2FVt3ZB")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FATPENGU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FATPENGU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FATPENGU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

