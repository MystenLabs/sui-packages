module 0xd1f6414f9a05efb838b26ecd3a55042f284bf6811d3778aa36e63aa65d27a4ae::mog {
    struct MOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOG>(arg0, 6, b"MOG", b"SUI $MOG", b"$MOG is the internets first culture coin. But its more than just a coin, its tokenized winning. $MOG is effortless cosmic domination and unadulterated success distilled into computer photons. Mog is a movement, it is a way of life. Since day one, Mog has built its community organically from the ground-up with one goal in mind: to be a culture-defining force in the crypto ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_17_89badc3de8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

