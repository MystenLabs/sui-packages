module 0xddb6dc4cd835752cfaa8f9e3f6fc7cbbba544048a26dddd6dfb4733858865d4c::pie {
    struct PIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIE>(arg0, 9, b"PIE", b"Sui Pie", b"Sui Pie Meme Party Let's Go", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1504523080919572482/7EdB_H7Y_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PIE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

