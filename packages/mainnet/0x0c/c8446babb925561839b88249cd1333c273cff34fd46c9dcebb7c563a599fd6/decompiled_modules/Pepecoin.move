module 0xcc8446babb925561839b88249cd1333c273cff34fd46c9dcebb7c563a599fd6::Pepecoin {
    struct PEPECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPECOIN>(arg0, 9, b"PEPE", b"Pepecoin", b"pepe the meme. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1651688795429822464/cmDeEncE_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPECOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPECOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

