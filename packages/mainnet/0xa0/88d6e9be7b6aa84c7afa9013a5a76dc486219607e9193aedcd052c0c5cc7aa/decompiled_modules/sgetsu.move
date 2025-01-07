module 0xa088d6e9be7b6aa84c7afa9013a5a76dc486219607e9193aedcd052c0c5cc7aa::sgetsu {
    struct SGETSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGETSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGETSU>(arg0, 9, b"Sgetsu", b"Suigetsu ", b"Suigetsu, the crazy water swordsman from the hit anime Naruto is here. This is a purely degen play. No website, tg, or social media. Fair launch, no rugs. Just trade and have fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a80c577e26dee968e03074b250f661ffblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SGETSU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGETSU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

