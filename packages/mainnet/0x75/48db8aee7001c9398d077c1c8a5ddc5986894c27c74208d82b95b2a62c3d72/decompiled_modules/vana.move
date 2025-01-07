module 0x7548db8aee7001c9398d077c1c8a5ddc5986894c27c74208d82b95b2a62c3d72::vana {
    struct VANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: VANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VANA>(arg0, 9, b"VANA", b"Vana", b"Sui Vana", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1840397922761879552/HzOjl_JZ_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VANA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VANA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

