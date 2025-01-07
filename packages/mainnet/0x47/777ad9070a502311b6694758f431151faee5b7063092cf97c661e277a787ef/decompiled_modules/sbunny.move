module 0x47777ad9070a502311b6694758f431151faee5b7063092cf97c661e277a787ef::sbunny {
    struct SBUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBUNNY>(arg0, 6, b"Sbunny", b"Suibunny", b"SuiBunny is a fun and playful meme token built on the Sui blockchain, featuring a mischievous yet adorable bunny mascot. Combining the vibrant energy of the Sui ecosystem with a touch of humor, SuiBunny aims to engage the community through lightheartedness while embracing the power of decentralized finance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000359_b58d0a4b29.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBUNNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBUNNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

