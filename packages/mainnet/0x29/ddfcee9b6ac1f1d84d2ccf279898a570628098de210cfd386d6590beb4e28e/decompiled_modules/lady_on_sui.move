module 0x29ddfcee9b6ac1f1d84d2ccf279898a570628098de210cfd386d6590beb4e28e::lady_on_sui {
    struct LADY_ON_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LADY_ON_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LADY_ON_SUI>(arg0, 9, b"LADY", b"Lady On Sui", b"Lady on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776377160175-d008cdc7dc05b7fa4df6e14b3fa81e26.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<LADY_ON_SUI>>(0x2::coin::mint<LADY_ON_SUI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LADY_ON_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LADY_ON_SUI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

