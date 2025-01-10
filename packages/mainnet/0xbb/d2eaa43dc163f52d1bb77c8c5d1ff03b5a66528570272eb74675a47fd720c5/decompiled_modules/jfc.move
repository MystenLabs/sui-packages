module 0xbbd2eaa43dc163f52d1bb77c8c5d1ff03b5a66528570272eb74675a47fd720c5::jfc {
    struct JFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: JFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JFC>(arg0, 6, b"JFC", b"Jackie Fine Chicken", b"It's Finger Clickin' Good.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a625619927d60f2e74a7708288c305a4_f2859398a3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JFC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

