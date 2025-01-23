module 0x42aed3ce374a427324b4b69926981efd4b9ae9e88cfbf9c4f482c0befebe3d0c::sqc {
    struct SQC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQC>(arg0, 6, b"SQC", b"Square Cat", b"This is the first square cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/12112_96a4a450d7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQC>>(v1);
    }

    // decompiled from Move bytecode v6
}

