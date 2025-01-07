module 0xe91d40dd0a74fe39c3b5a7409d0de4d48732de166e539d26f8196572f4e8d104::cwr {
    struct CWR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CWR>(arg0, 6, b"CWR", b"Cat With Rose", b"A rose for you, because you're pawsome!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c8a95e05156bcf47a810dfffee53ef50_3f9cab927f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CWR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CWR>>(v1);
    }

    // decompiled from Move bytecode v6
}

