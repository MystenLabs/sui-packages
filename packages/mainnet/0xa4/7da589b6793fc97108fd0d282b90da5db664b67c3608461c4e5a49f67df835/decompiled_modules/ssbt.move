module 0xa47da589b6793fc97108fd0d282b90da5db664b67c3608461c4e5a49f67df835::ssbt {
    struct SSBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSBT>(arg0, 9, b"SBBT", b"SBBT", b"SBBT", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSBT>>(v1);
        0x2::coin::mint_and_transfer<SSBT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SSBT>>(v2);
    }

    // decompiled from Move bytecode v6
}

