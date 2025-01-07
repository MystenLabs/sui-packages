module 0x66eb73373eb1678c57e74dcdf6f374b9de1f9ac72583447946b9dba3d3541f65::dafuk {
    struct DAFUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAFUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAFUK>(arg0, 6, b"DAFUK", b"Dafuk", b"Dafuk?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_11_204806_8c08e1902c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAFUK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAFUK>>(v1);
    }

    // decompiled from Move bytecode v6
}

