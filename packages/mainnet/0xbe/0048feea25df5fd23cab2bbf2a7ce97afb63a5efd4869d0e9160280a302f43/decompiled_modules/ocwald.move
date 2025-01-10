module 0xbe0048feea25df5fd23cab2bbf2a7ce97afb63a5efd4869d0e9160280a302f43::ocwald {
    struct OCWALD has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCWALD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCWALD>(arg0, 6, b"OCWALD", b"OCWALD SUI", b"Ocwald is a large, blue octopus who takes residence in an apartment complex located in Big City. He lives there along with many other animals, such as Henry the penguin and a turtle named Buster. Ocwald will often play the piano while singing to his pet dog Weenie. Ocwald is known to say \"Oh, my gosh!\" on many occasions. He wears a life preserver when he is around water and loves Swizzleberry Swirl ice cream.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7615_65e6082d27.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCWALD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCWALD>>(v1);
    }

    // decompiled from Move bytecode v6
}

