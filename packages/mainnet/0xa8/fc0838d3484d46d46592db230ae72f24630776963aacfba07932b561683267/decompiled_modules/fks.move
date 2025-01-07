module 0xa8fc0838d3484d46d46592db230ae72f24630776963aacfba07932b561683267::fks {
    struct FKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FKS>(arg0, 6, b"FKS", b"FlokiSui", b"The meme that will make you happy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3004_f3da933a42.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

