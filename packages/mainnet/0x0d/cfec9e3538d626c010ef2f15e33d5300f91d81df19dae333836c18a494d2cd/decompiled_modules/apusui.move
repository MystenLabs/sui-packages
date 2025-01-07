module 0xdcfec9e3538d626c010ef2f15e33d5300f91d81df19dae333836c18a494d2cd::apusui {
    struct APUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: APUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APUSUI>(arg0, 6, b"APUSUI", b"Apu Apustaja On SUI", b"$APUSUI is the coin for all frens ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/APULOGO_9fa3adc600.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APUSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APUSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

