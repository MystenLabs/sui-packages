module 0x924505758e92a7f4356eb371732622555848ef110cdb8187463a6fa9eb38417b::DOGWIFCHRISTMASHAT {
    struct DOGWIFCHRISTMASHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGWIFCHRISTMASHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGWIFCHRISTMASHAT>(arg0, 6, b"DOGWIFCHRISTMASHAT", b"Dog wif iconic but new christmas hat", b"Christmas is comming. This cute dog wif christmas hat is the mascot for this BULLRUN crypto christmas.", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGWIFCHRISTMASHAT>>(v1);
        0x2::coin::mint_and_transfer<DOGWIFCHRISTMASHAT>(&mut v2, 4200000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGWIFCHRISTMASHAT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

