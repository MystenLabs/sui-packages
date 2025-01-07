module 0x89bcb2513647bc7fc9f03a42c0fa14e5d52ab1064400e2f180c04877d8faeb80::abe {
    struct ABE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABE>(arg0, 6, b"ABE", b"American Bird", x"4865792c20496d204162652120416d657269636173204f6666696369616c20426972642e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xd0dfca0b404e866dc9a3038bd2a545c6735d9fa9_e5461d9f69.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ABE>>(v1);
    }

    // decompiled from Move bytecode v6
}

