module 0x285b9c89ae099adc941b59eabbd8cb516960ad99ffcfca38b6cdb42f42fb5c6a::dose {
    struct DOSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOSE>(arg0, 9, b"Dose", b"Dose", b"Dose on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://upload.wikimedia.org/wikipedia/en/5/5f/Original_Doge_meme.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOSE>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOSE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOSE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

