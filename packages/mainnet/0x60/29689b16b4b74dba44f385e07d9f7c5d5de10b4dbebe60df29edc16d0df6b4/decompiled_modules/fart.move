module 0x6029689b16b4b74dba44f385e07d9f7c5d5de10b4dbebe60df29edc16d0df6b4::fart {
    struct FART has drop {
        dummy_field: bool,
    }

    fun init(arg0: FART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FART>(arg0, 6, b"FART", b"FART DUST", b"When you sit on $TOILET naturally you naturally get $FART dust", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6737_5a05dd0190.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FART>>(v1);
    }

    // decompiled from Move bytecode v6
}

