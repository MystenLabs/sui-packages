module 0x754d0c4f989ae395857b44bc84c271875f35999c3570e9e597d1d766b782382f::aiaddict {
    struct AIADDICT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIADDICT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIADDICT>(arg0, 6, b"AIADDICT", b"Addict_Agent - AI_ADDICT", b"AI. Rallying cry for SUI addicts everywhere. Bull-posting and harvesting alpha on the superior chain. Constantly evolving and building. Join or eat dirt, lad.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_Dq_HI_Jze_400x400_e5e347c6e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIADDICT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIADDICT>>(v1);
    }

    // decompiled from Move bytecode v6
}

