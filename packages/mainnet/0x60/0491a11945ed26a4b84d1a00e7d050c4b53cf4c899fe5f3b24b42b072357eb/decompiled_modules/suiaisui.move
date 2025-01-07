module 0x600491a11945ed26a4b84d1a00e7d050c4b53cf4c899fe5f3b24b42b072357eb::suiaisui {
    struct SUIAISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAISUI>(arg0, 6, b"SUIAISUI", b"SUI AI", b"The Future of Memes Meets AI on the Sui Network!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_14_181422990_893a3289c3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIAISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

