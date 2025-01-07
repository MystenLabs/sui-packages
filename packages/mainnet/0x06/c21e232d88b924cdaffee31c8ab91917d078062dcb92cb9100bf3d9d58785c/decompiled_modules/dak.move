module 0x6c21e232d88b924cdaffee31c8ab91917d078062dcb92cb9100bf3d9d58785c::dak {
    struct DAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAK>(arg0, 6, b"dak", b"dak", b"Hi, I'm dak on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.ibb.co/qJtYL10/ava-1.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DAK>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

