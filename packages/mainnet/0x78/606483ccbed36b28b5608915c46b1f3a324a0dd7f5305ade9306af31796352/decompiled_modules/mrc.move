module 0x78606483ccbed36b28b5608915c46b1f3a324a0dd7f5305ade9306af31796352::mrc {
    struct MRC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRC>(arg0, 9, b"MRCCOIN", b"MRC", b"Coin for MrcScription Protocal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://6ywqtjcj6ytcbcjrphjuaf3hpqgdj6yzdvlpawamchdv565btw7a.arweave.net/9i0JpEn2JiCJMXnTQBdnfAw0-xkdVvBYDBHHXvuhnb4")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MRC>>(0x2::coin::mint<MRC>(&mut v2, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MRC>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MRC>>(v2);
    }

    public fun mrc_decimals() : u8 {
        9
    }

    // decompiled from Move bytecode v6
}

