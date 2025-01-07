module 0x1dfd9f275d446d49975e7bd4b51621ac66558481454dac5a5a8ac2bb399c3b05::hfish {
    struct HFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HFISH>(arg0, 6, b"HFISH", b"HOPFISH", b"They say fish don't jump, I'm an exception #sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HOP_2e2287507d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

