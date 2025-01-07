module 0x96893a3a33ecb993fa2fa76bc535f0cdd747e73c80b85545c30fb8ff20e20f79::suicoste {
    struct SUICOSTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICOSTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICOSTE>(arg0, 6, b"Suicoste", b"Suicoste - Fun in Sui", b"A mediocre combination of Sui and the Lacoste brand. As there is nothing like it on the market, Let's hope it goes viral and the value goes to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suicoste_Move_Pump_4ed8f7a39a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICOSTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICOSTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

