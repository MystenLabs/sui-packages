module 0x3000e3ae15ed8bae0e97d0964c8abfbdcae11e30fd3e6d3f79be3d2c2de56a4c::puma {
    struct PUMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMA>(arg0, 6, b"PUMA", b"SUIPUMA", b"SUIPUMA IS THE MOST PREDATOR IN THE SUI NETWORK ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000197804_08b1718972.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

