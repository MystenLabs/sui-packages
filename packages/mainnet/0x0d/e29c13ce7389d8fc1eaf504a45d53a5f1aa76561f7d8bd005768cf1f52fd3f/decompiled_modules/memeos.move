module 0xde29c13ce7389d8fc1eaf504a45d53a5f1aa76561f7d8bd005768cf1f52fd3f::memeos {
    struct MEMEOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEOS>(arg0, 6, b"MEMEOS", b"MEME OS", b"Website: https://www.memeos.online/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bdogbg_79b0efa883.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEMEOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

