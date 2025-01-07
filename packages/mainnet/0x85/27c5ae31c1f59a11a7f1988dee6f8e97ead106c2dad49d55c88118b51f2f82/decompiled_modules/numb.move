module 0x8527c5ae31c1f59a11a7f1988dee6f8e97ead106c2dad49d55c88118b51f2f82::numb {
    struct NUMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUMB>(arg0, 6, b"NUMB", b"Numb", b"nothing bothers me anymore", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/numb_5e17c40e3e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

