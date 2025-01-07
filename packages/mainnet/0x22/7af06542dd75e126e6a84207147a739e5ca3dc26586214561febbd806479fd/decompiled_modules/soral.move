module 0x227af06542dd75e126e6a84207147a739e5ca3dc26586214561febbd806479fd::soral {
    struct SORAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SORAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SORAL>(arg0, 6, b"SORAL", b"SoralInu", b"MERCI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/soral_3e8c52c840.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SORAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SORAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

