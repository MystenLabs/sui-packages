module 0xa564abbc463a50776dc5a8fc7dd8ec3e975f6599cd51535c13b905937ca02662::OH {
    struct OH has drop {
        dummy_field: bool,
    }

    fun init(arg0: OH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OH>(arg0, 6, b"OH", b"Only in Ohio", b"Ohio will be eliminated", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmdrED1KiwTYFQvE4FrN3Bge5jsAt66PPzMyvP9XfRsgzw")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

