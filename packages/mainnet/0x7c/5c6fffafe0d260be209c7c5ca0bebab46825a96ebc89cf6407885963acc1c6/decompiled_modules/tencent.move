module 0x7c5c6fffafe0d260be209c7c5ca0bebab46825a96ebc89cf6407885963acc1c6::tencent {
    struct TENCENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TENCENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TENCENT>(arg0, 6, b"Tencent", b"Proy", b"Fortune Global 500. CEO of Tencent", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0cff_iieqapu5295295_fc0d031981.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TENCENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TENCENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

