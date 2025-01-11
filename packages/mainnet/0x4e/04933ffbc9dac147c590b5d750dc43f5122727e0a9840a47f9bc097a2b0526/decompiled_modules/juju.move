module 0x4e04933ffbc9dac147c590b5d750dc43f5122727e0a9840a47f9bc097a2b0526::juju {
    struct JUJU has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUJU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUJU>(arg0, 6, b"Juju", b"JUJU ON SUI", x"4a554a55206973206e6f74206172742c206c657420616c6f6e652041492e0a6974206973206a7573742061206d656d652e0a0a205449524544204f46202046414b452020414920204147454e5420205343414d200a0a2054414b455320594f5520204241434b2020544f2054484520205245414c204d454d452020574f524c44200a0a204a554a5520204c4f56452020594f552020414c4c20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250112_003717_070_95d25967f2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUJU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUJU>>(v1);
    }

    // decompiled from Move bytecode v6
}

