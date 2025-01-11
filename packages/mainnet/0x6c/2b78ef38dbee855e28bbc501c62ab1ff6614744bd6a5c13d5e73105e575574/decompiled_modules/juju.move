module 0x6c2b78ef38dbee855e28bbc501c62ab1ff6614744bd6a5c13d5e73105e575574::juju {
    struct JUJU has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUJU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUJU>(arg0, 6, b"JUJU", b"juju", x"4a554a55206973206e6f74206172742c206c657420616c6f6e652041492e206974206973206a7573742061206d656d652e20205449524544204f46202046414b452020414920204147454e5420205343414d20202054414b455320594f5520204241434b2020544f2054484520205245414c204d454d452020574f524c442020204a554a5520204c4f56452020594f552020414c4c200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/RJ_Ve_H9hx_400x400_aa1c0ae32f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUJU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUJU>>(v1);
    }

    // decompiled from Move bytecode v6
}

