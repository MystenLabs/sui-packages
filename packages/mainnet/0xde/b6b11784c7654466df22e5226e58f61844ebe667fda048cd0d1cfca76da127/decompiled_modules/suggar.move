module 0xdeb6b11784c7654466df22e5226e58f61844ebe667fda048cd0d1cfca76da127::suggar {
    struct SUGGAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUGGAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUGGAR>(arg0, 6, b"Suggar", b"suggardog", b"i m suggar, buy me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mi_dog_in_fuckin_sui_d4fd4f19e9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUGGAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUGGAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

