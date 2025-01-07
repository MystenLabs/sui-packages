module 0xf2abdf91bff2b5fd3bc951406844264ef98c56e7d7254f622f5792e5b29af680::sbiao {
    struct SBIAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBIAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBIAO>(arg0, 6, b"SBIAO", b"Sui Biao Qing", b"Biaoqing is the most famous panda in the world and the true OG of ASIAN MEMES. Biaoqing is the Pepe of EAST, and he's now ready to conquer the SUI blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6805_b7e5ff0b68.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBIAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBIAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

