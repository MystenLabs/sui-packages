module 0x128261c53c971dbe53a79756f2308f26cdd12b98e1140a2e14772e7e2d9d807d::speed {
    struct SPEED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEED>(arg0, 9, b"SPEED", b"SPEED", x"4e69676761205370656564206f6e20535549200a2068747470733a2f2f747769747465722e636f6d2f6973686f777370656564737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSlvJ4EvtXoNWrVQEAKD1ZHkMiUul26UrJhcOHMwGNocgKDduVl")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPEED>>(v1);
        0x2::coin::mint_and_transfer<SPEED>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEED>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

