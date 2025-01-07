module 0xbd344679460ad783f784f1a77ea3aeaadd7bff50717fe2c1a5b1065c9e57f89d::donke {
    struct DONKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONKE>(arg0, 9, b"DONKE", b"Sui Donke", b"Sui Donke making the fun and craziness on the blockchain prepare for the ride.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1793827314813325312/D13Tvrjp.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DONKE>(&mut v2, 15000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONKE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

