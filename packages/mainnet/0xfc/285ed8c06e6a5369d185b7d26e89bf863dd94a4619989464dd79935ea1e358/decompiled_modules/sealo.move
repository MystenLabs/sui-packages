module 0xfc285ed8c06e6a5369d185b7d26e89bf863dd94a4619989464dd79935ea1e358::sealo {
    struct SEALO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEALO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEALO>(arg0, 6, b"SEALO", b"Sealo", b"Meet Sealo  the memecoin making waves in the crypto ocean!  Tired of seeing your portfolio sink? Sealo is here to flip the script and leave the whales behind.  Packed with more potential than you can imagine, this token is ready to ride the waves. Dont stay stranded on the shore  dive in, make a splash, and ride the Sealo wave to the top! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ga_Eg_S_Sq_Xc_A_Anc_UD_70ab735465.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEALO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEALO>>(v1);
    }

    // decompiled from Move bytecode v6
}

