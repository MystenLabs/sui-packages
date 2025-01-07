module 0x8284215367ca7a7c727d9ffd94477363b1c18bd14e57623bcc0d94eb9e2eaf39::scd {
    struct SCD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCD>(arg0, 6, b"SCD", b"SUiCAtDOg", b"SUiCAtDOg SUiCAtDOg SUiCAtDOg SUiCAtDOg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fb59e59e533e95ab36daeba0163d626e_af300aa7b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCD>>(v1);
    }

    // decompiled from Move bytecode v6
}

