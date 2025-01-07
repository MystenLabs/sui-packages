module 0x5c3e09c8fc86a83217a11150ef3c028d07ebf9714e749e03155132905f469367::scz {
    struct SCZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCZ>(arg0, 6, b"SCZ", b"Sucziba", b"Decentralized power. Free , always crypto. We will fly it to the moon with decentralized power", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cf0a1_5511_44f0_b747_14257051dc61_b5a659cde3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

