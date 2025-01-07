module 0x4b1bdfa77c1fe519f0134660be0df2ac7cc8211776aafb01a84ff3708a2e8f65::pscat {
    struct PSCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSCAT>(arg0, 6, b"PSCAT", b"Pixel Sui Cat", b"This is the next move toward memecoins art of cats , the first pixel cat in the ocean blockchain the leader of the moves (SUI)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PSCAT_fc7e24a958.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

