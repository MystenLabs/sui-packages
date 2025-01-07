module 0xaf15fbb1c46480be6f33f55a4553b64e51e30d4093256f914ce78bf136bc60c0::FLOKICEO {
    struct FLOKICEO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FLOKICEO>, arg1: 0x2::coin::Coin<FLOKICEO>) {
        0x2::coin::burn<FLOKICEO>(arg0, arg1);
    }

    fun init(arg0: FLOKICEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOKICEO>(arg0, 6, b"FLOKICEO", b"Sui FLoki CEO", b"Twitter: @flokiceo, Telegram: t.me/flokiceo", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLOKICEO>>(v1);
        0x2::coin::mint_and_transfer<FLOKICEO>(&mut v2, 300000000000000, 0x2::address::from_u256(49081472407194817422147482193596819345884407638953529932970525219145338348528), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOKICEO>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FLOKICEO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FLOKICEO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

