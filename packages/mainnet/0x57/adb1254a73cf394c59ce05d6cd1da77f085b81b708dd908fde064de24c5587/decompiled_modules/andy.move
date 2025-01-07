module 0x57adb1254a73cf394c59ce05d6cd1da77f085b81b708dd908fde064de24c5587::andy {
    struct ANDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANDY>(arg0, 6, b"ANDY", b"Andy On Sui", b"Andy Token ($ANDY) is a community-driven meme token on the Sui Chain, bringing humor and whimsy to the blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/J9h1_HZ_5_400x400_ad410d13f2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

