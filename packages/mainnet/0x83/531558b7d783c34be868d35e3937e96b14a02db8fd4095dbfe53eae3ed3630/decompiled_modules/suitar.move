module 0x83531558b7d783c34be868d35e3937e96b14a02db8fd4095dbfe53eae3ed3630::suitar {
    struct SUITAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITAR>(arg0, 6, b"SUITAR", b"Sui Star Fish", x"476c6f77206272696768746c79206c696b65206120737461722062656e656174682074686520646570746873206f6620746865206f6365616e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/STAR_Fish_6494b41d8b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

