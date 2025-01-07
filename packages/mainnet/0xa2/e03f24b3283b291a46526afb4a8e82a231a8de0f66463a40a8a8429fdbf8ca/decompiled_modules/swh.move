module 0xa2e03f24b3283b291a46526afb4a8e82a231a8de0f66463a40a8a8429fdbf8ca::swh {
    struct SWH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWH>(arg0, 9, b"SWH", b"SuiWifHat", b"SuiWifHat - new gem meme coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.shopify.com/s/files/1/2281/6067/files/dogwifhat_sticker.png?v=1702942834")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SWH>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWH>>(v1);
    }

    // decompiled from Move bytecode v6
}

