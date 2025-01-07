module 0x33ad00ec0dcdb761189c50350b03df52fba2d350d38f3b44199bb0e3a5f69899::sealo {
    struct SEALO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEALO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEALO>(arg0, 6, b"SEALO", b"SEALOONSUI", b"Making Waves in Your Wallet. Seal the Deal. Seal your Fortune.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/paz_Jgp_AS_400x400_2af32c76f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEALO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEALO>>(v1);
    }

    // decompiled from Move bytecode v6
}

