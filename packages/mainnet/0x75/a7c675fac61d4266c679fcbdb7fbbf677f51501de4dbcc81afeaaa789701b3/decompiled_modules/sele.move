module 0x75a7c675fac61d4266c679fcbdb7fbbf677f51501de4dbcc81afeaaa789701b3::sele {
    struct SELE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SELE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SELE>(arg0, 6, b"SELE", b"Sele on Sui", b"meet with SELE in Sui, the largest animal in history in the world, we are sure that this Sele is the commander of the other animals in SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053470_71369053b0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SELE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SELE>>(v1);
    }

    // decompiled from Move bytecode v6
}

