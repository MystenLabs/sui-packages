module 0x39871c880e07c2eec3acc9bca9c34098cddc7c948a03de60a1f3a1904fd0417a::sb {
    struct SB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SB>(arg0, 6, b"SB", b"SUIBASE ", b"THE GATEWAY TO MARS BY SUIX AEROSPACE, FOUNDED BY  MYSTEN LABS.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732114769848.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

