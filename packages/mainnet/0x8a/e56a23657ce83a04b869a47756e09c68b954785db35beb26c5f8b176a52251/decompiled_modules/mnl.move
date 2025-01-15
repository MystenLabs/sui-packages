module 0x8ae56a23657ce83a04b869a47756e09c68b954785db35beb26c5f8b176a52251::mnl {
    struct MNL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNL>(arg0, 6, b"MnL", b"MONKEY AND THE ELEPHANT", b"Join the hilarious journey of the Monkey and the Elephant to the moon, all backed and supported by the community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_1054a2dbac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MNL>>(v1);
    }

    // decompiled from Move bytecode v6
}

