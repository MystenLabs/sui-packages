module 0x1e325e1c9422fef317e5eaad6d3eb6780fc34c9729fa61ac8abe83871458479a::tlk {
    struct TLK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TLK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TLK>(arg0, 6, b"TLK", b"Tiger Lake", b"tiger lake is a dex portal for fui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_3cd5d19aa6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TLK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TLK>>(v1);
    }

    // decompiled from Move bytecode v6
}

