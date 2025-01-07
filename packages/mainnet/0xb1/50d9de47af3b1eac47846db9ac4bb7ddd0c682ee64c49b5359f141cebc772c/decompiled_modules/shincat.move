module 0xb150d9de47af3b1eac47846db9ac4bb7ddd0c682ee64c49b5359f141cebc772c::shincat {
    struct SHINCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHINCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHINCAT>(arg0, 6, b"SHINCAT", b"Shincat coin", b"Lorem ipsum dolor sit amet consectetur adipisicing elit. Maiores, vitae doloribus, nobis eum voluptates eaque odit, tenetur consectetur inventore quaerat error dolor facere molestiae", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000050374_b0425a822b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHINCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHINCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

