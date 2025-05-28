module 0x99bb6896fcd57a43e9c8671bd1d27bfd50b96caac4c94f7d0772d480ed5ef8d4::attn {
    struct ATTN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATTN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATTN>(arg0, 9, b"ATTN", b"Price Attention", b"Price Attention is all you need", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/520d696c12a00659917f60bd728ba83dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ATTN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATTN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

