module 0x49d53972723e5176c17ce44ba9bf2d84b7b3ebac805dd17fac9b718bbd4c1709::scat {
    struct SCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAT>(arg0, 6, b"SCAT", b"suicat", b"I am Suicat, the child of a fish and a cat . Even though I come from two different worlds, Im really friendly and only want to take care of my community.  My mission is to bring harmony and joy to everyone, with an aquatic and feline touch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9d3f2829_ff6f_4ddb_ad31_a1521af8edaf_2fd0e1ae0a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

