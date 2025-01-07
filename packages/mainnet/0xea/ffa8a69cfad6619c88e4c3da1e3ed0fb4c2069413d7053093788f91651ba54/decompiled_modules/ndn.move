module 0xeaffa8a69cfad6619c88e4c3da1e3ed0fb4c2069413d7053093788f91651ba54::ndn {
    struct NDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NDN>(arg0, 6, b"NDN", b"Ndog Network", b"Ndog Network is a government token to maintain the stability of the $Ndog network, for governance and rewards for loyal users.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000148921_2a4d9a0a48.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

