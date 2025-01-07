module 0x5e0d719066ab8810ceba642507e93300a8d18d8b3abfa447fd587d935b2e46c2::og {
    struct OG has drop {
        dummy_field: bool,
    }

    fun init(arg0: OG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OG>(arg0, 6, b"OG", b"Only Green", x"22526564204d61726b6574207965737465726461792c204f6e6c7920477265656e20544f444159220a0a466f6c6c6f77696e6720746865206d61726b6574207472656e64732c207265616368696e6720677265656e65722063616e646c657320616d6f6e67206368617274732c20244f47206d616e69666573747320636f6e74696e756f75732070756d70206f6e2074686520477265656e204d61726b65742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_00_26_12_5bc5c37e6d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OG>>(v1);
    }

    // decompiled from Move bytecode v6
}

