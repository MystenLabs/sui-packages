module 0xe43b719881f367b89c76ac7ab94feb6abe412383567ef981d33400512d5bac21::raahhh {
    struct RAAHHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAAHHH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAAHHH>(arg0, 9, b"RAAHHH", b"Oil Token", b"Just oil", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/389521c3-4e9a-4e40-8e84-02df72fdbdf8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAAHHH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAAHHH>>(v1);
    }

    // decompiled from Move bytecode v6
}

