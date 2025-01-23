module 0xec6bdc261c5bf1bcdaac388f87bec7f1c438582f20ade4ce97882470a07d80ba::sAfSui {
    struct SAFSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAFSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAFSUI>(arg0, 9, b"sysAfSUI", b"SY sAfSUI", b"SY scallop sAfSUI", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAFSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAFSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

