module 0x737ead67630854fc0775f6ff901e8a2ac9f8a6304adbce228b5db478b5f3fa6::suishib {
    struct SUISHIB has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUISHIB>, arg1: 0x2::coin::Coin<SUISHIB>) {
        0x2::coin::burn<SUISHIB>(arg0, arg1);
    }

    fun init(arg0: SUISHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHIB>(arg0, 2, b"SuiShib", b"SuiShib", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1683222398484-e5071bfa43f0848c21571df60229ca89.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISHIB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHIB>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUISHIB>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUISHIB>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

