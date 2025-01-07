module 0x455f34edc4f8af94ee8f47b59deaf63d271cb7617362df1946e2276c2f24bc4e::nigabob {
    struct NIGABOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGABOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIGABOB>(arg0, 6, b"NIGABOB", b"Community owned NIGGABOB", b"It`s a community owned version of nigga bob token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/43534534_f132905224.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIGABOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIGABOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

