module 0xf2a908f7c84ea0088f4faca86a8ec635f61a3483e9cdeb1bf1b6f19a706fcdd1::frogtato {
    struct FROGTATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGTATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGTATO>(arg0, 6, b"FROGTATO", b"frogtato", b"Frogtato is a whimsical crypto collectible thats half frog, half potato. Combining the playful charm of a frog with the hearty nature of a potato, this unique digital asset hops into the blockchain world with a quirky sense of humor. Whether youre drawn to its amphibious agility or its rustic, spud-like appeal, Frogtato promises to bring both fun and originality to any crypto collection.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/frogtato_cffa4a164a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGTATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGTATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

