module 0xfed57bee92764f26c4d2c24b00054bede812efd493c1aa14d334634b91e2bd76::wif {
    struct WIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIF>(arg0, 6, b"WIF", b"dogwifseal", b"we've finally found the perfect representation of $wif on the sui network. dogwifseal. community based token - all socials already setup!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_wiener_dog_befriends_a_seal_v0_yq51fe3k95i91_67e63212da.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

