module 0xd180f03550ef17409d08cd570c6b9981d7b4d7124983d82960b57292f6ff7e6e::tdk {
    struct TDK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TDK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TDK>(arg0, 6, b"TDK", b"They Don't Know", b"They don't know...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3414_052eabb4ed.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TDK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TDK>>(v1);
    }

    // decompiled from Move bytecode v6
}

