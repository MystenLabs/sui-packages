module 0x6de6b5ce170946a6991270611fcc8532c8633d7fbb998a4e9982eca125c816e0::scz {
    struct SCZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCZ>(arg0, 6, b"SCZ", b"Sucziba", b"Decentralized power. Always crypto. We will fly it to the moon with decentralized power. Free", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cf0a1_5511_44f0_b747_14257051dc61_3acbc6f906.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

