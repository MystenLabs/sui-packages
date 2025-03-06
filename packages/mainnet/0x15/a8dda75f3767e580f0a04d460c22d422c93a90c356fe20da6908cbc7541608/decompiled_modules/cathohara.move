module 0x15a8dda75f3767e580f0a04d460c22d422c93a90c356fe20da6908cbc7541608::cathohara {
    struct CATHOHARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATHOHARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATHOHARA>(arg0, 9, b"CATHOHARA", b"Catherine O'Hara", b"Born: March 4, 1954, Toronto, Canada", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://a1.moviepassblack.com/w3/assets/CATHOHARA.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CATHOHARA>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATHOHARA>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATHOHARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

