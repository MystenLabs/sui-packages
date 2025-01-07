module 0xabd6de3c39471eee48e363e86124a80172b0a642e1916a677d421b7445ffd58c::suisage {
    struct SUISAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISAGE>(arg0, 6, b"SUISAGE", b"Suisage", b"The Legendary Suisage's Quest for the Meme Footlong Crown", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/460365239_827613039224645_2178186372551022521_n_c19c637810.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISAGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISAGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

