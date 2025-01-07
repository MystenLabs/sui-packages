module 0x804e080c62845f2ad3d3894df441aaa32651bd7d795274a6d92b270a0f149567::suicats {
    struct SUICATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICATS>(arg0, 6, b"suicats", b"suicats", b"suicats pair launch on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://png.pngtree.com/png-clipart/20220612/ourmid/pngtree-meme-cat-png-image_5002938.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUICATS>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICATS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

