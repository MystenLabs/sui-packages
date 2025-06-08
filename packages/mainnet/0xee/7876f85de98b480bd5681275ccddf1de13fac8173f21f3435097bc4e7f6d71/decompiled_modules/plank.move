module 0xee7876f85de98b480bd5681275ccddf1de13fac8173f21f3435097bc4e7f6d71::plank {
    struct PLANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLANK>(arg0, 6, b"PLANK", b"Plankton", b"Plankton is done chasing the Krabby Patty formula... Now he launching his own meme token: PLANK. His only mission? To take over crypto just like he tried to take over the Krusty Krab!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibggs3njyhvp35kd4m53pkaltfakloohzq57seo6dp3lofj2dqipa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLANK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PLANK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

