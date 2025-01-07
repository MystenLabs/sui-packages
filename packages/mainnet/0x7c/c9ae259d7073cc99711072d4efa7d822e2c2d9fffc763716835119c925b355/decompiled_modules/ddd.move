module 0x7cc9ae259d7073cc99711072d4efa7d822e2c2d9fffc763716835119c925b355::ddd {
    struct DDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDD>(arg0, 6, b"DDD", b"Gokku da baDDDie", b"gokku da baDDDie. no cap ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/471f2bf168c654e_dc08a5625b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

