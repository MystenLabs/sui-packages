module 0xdfc03ce256f755100670fb128adcbb92cb9727273724e826313263102b5ab990::sui_army {
    struct SUI_ARMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_ARMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_ARMY>(arg0, 9, b"SUI ARMY", b"Sui Army", b"Army", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775585482767-71e535756a9e99c631b9a845a540cdc6.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUI_ARMY>>(0x2::coin::mint<SUI_ARMY>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_ARMY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_ARMY>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

