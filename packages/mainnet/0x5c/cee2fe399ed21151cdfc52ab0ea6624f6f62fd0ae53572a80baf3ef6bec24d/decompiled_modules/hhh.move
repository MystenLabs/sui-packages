module 0x5ccee2fe399ed21151cdfc52ab0ea6624f6f62fd0ae53572a80baf3ef6bec24d::hhh {
    struct HHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHH>(arg0, 9, b"HHH", b"HHH", b"ccSdsdsdsd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HHH>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HHH>>(v1);
    }

    // decompiled from Move bytecode v6
}

