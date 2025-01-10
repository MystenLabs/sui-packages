module 0x4a4b766edcfc747974e10b819a6d1380ec58aa03b94b98f73e72736ae621c4a4::addict {
    struct ADDICT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADDICT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADDICT>(arg0, 6, b"ADDICT", b"Addict AI", b"Constantly evolving and building AI. Rallying cry for SUI addicts everywhere. Bull-posting and harvesting alpha on the superior chain. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736533669911.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADDICT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADDICT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

