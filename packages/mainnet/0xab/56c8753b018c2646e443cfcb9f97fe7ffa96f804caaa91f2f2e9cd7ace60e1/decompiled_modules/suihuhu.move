module 0xab56c8753b018c2646e443cfcb9f97fe7ffa96f804caaa91f2f2e9cd7ace60e1::suihuhu {
    struct SUIHUHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHUHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHUHU>(arg0, 6, b"SuiHuHu", b"HuHu", b"[Tongmai & E-BOOK e-books] are now available Shopeereurl.cc/Y0N6ao Overseas Overseas (Taiwan is also ok) Fanhouse Maple Forest Hall reurl.cc/WRaOoe Booky reurl.cc/LWmGm4 PChomereurl.cc/6QOln6 e-book BOOTH huhubooth.booth.pm CXC cxc.today/zh/store/huhu/ physical store Tiger's Nest West Pier G77 Please refer to each platform for general selling prices and product inventory", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/666_f0dd1ddfa6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHUHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIHUHU>>(v1);
    }

    // decompiled from Move bytecode v6
}

