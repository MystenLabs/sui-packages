module 0x2ae9860fbe402ba92d449430626f35e2dc42b94e1f1f0439215d9128165c1173::bmp {
    struct BMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMP>(arg0, 6, b"BMP", b"BabyMovePump", b"It's like MovePmp, but less", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_45_d7ea683691.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

