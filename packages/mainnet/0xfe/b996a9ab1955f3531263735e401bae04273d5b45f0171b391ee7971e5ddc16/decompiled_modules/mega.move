module 0xfeb996a9ab1955f3531263735e401bae04273d5b45f0171b391ee7971e5ddc16::mega {
    struct MEGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEGA>(arg0, 9, b"MEGA", b"MEGA", b"MEGA1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTO14CbwyaVny0hrn-ohDb0d-tBFAKlGtOA7Q&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEGA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEGA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

