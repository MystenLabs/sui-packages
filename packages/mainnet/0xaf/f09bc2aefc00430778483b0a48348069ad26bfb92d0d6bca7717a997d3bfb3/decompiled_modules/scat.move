module 0xaff09bc2aefc00430778483b0a48348069ad26bfb92d0d6bca7717a997d3bfb3::scat {
    struct SCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAT>(arg0, 9, b"SCAT", b"Sphynx cat", b"Sui CAt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.guim.co.uk/img/media/6bddcc4d11116c1d28a452023ad5523012b2f572/146_619_4372_2623/master/4372.jpg?width=1200&height=900&quality=85&auto=format&fit=crop&s=62620d518227d5e74123cfc09645de10"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCAT>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SCAT>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

