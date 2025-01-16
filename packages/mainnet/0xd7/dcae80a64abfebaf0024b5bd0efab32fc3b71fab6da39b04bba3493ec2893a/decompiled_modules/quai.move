module 0xd7dcae80a64abfebaf0024b5bd0efab32fc3b71fab6da39b04bba3493ec2893a::quai {
    struct QUAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUAI>(arg0, 6, b"QUAI", b"AI_Quack", b"Frogging into The Future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000077892_1c85872d85.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

