module 0x8617b4dc3fd02cc34b4473dd47ef08b94073e772b94c48db3231a1dcff64ac2::rabby {
    struct RABBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RABBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RABBY>(arg0, 9, b"RABBY", b"RabbitRage", b"RABBY a wild energetic meme to break the Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1522017422550528001/6AceRKJQ.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RABBY>(&mut v2, 210000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RABBY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RABBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

