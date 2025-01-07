module 0x5f4cdd8bdf24ac9ed21ca45a5a6ab9512a63107cb3a42598a61fd4a69f02b615::sgk {
    struct SGK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGK>(arg0, 6, b"SGK", b"Sui GoKu", b"Come with me to find the last dragon balls!!! Don't miss your wish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_27_09_15_38_cfa2bb50cb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGK>>(v1);
    }

    // decompiled from Move bytecode v6
}

