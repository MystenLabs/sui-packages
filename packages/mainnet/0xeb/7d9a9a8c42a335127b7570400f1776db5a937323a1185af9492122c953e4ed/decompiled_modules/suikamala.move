module 0xeb7d9a9a8c42a335127b7570400f1776db5a937323a1185af9492122c953e4ed::suikamala {
    struct SUIKAMALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKAMALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKAMALA>(arg0, 6, b"SUIKAMALA", b"SUI KAMALA", b"This is fan token for kamala Harris on SUI! network! happy whaling!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_0568aa93c9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKAMALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKAMALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

