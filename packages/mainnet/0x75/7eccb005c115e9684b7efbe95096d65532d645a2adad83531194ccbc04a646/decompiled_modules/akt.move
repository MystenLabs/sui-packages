module 0x757eccb005c115e9684b7efbe95096d65532d645a2adad83531194ccbc04a646::akt {
    struct AKT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKT>(arg0, 6, b"AKT", b"Akita on SUI", b"Hold $Akita become BILLIONAIRES!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0ge_HP_2_S_400x400_09d143d5a4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AKT>>(v1);
    }

    // decompiled from Move bytecode v6
}

