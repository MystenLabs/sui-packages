module 0x6b8342936c2dc5c8f394b267306f9e41043e6186d7cf91c356219ca8c811b39b::muttski {
    struct MUTTSKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUTTSKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUTTSKI>(arg0, 6, b"MUTTSKI", b"Muttski", x"576f6f6620776f6f662c20796561682077652073746179207374726f6e672c20200a576f6f6620776f6f662c207765206265656e206865726520616c6c20616c6f6e672c20200a576f6f6620776f6f662c207468726f7567682074686520686967687320616e6420746865206c6f77732c20200a4d757474736b697320686572652c20796561682c206576657279626f6479206b6e6f777321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000060220_d9840f1f16.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUTTSKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUTTSKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

