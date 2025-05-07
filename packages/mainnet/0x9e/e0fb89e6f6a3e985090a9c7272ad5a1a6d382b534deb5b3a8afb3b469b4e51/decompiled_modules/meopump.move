module 0x9ee0fb89e6f6a3e985090a9c7272ad5a1a6d382b534deb5b3a8afb3b469b4e51::meopump {
    struct MEOPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOPUMP>(arg0, 6, b"MeoPump", b"MeoMeo Pump", b"MeoPump Pump Pump 1M$", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_1_3ac64f4633.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEOPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

