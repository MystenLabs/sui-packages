module 0xa154d23fb8aec7ba09724d79f067c2304a6d8885cc84b0f897784864ce3a6e95::ctk {
    struct CTK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTK>(arg0, 6, b"CTK", b"Camel The King", b"king of the desert #1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/raf_360x360_075_t_fafafa_ca443f4786_orig_1e1431c46e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTK>>(v1);
    }

    // decompiled from Move bytecode v6
}

