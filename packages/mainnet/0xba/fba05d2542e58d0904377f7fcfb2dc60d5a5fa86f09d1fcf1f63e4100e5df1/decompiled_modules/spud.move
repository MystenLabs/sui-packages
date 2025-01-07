module 0xbafba05d2542e58d0904377f7fcfb2dc60d5a5fa86f09d1fcf1f63e4100e5df1::spud {
    struct SPUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPUD>(arg0, 6, b"SPUD", b"Jacket Potato", b"A cute potatoe, with cheese and beans. Practically shouting for a cup of tea and a biscuit!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/957a94bb_434a_41fb_8ca9_d22bbb2b5522_1_922059121e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

