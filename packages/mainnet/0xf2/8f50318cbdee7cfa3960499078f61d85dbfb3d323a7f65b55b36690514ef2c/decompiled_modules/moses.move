module 0xf28f50318cbdee7cfa3960499078f61d85dbfb3d323a7f65b55b36690514ef2c::moses {
    struct MOSES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOSES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOSES>(arg0, 6, b"MOSES", b"Sui Moses", b"Meet $MOSES. Sui Moses, parting the seas and leading degens to the promised land. With a staff of memes and a community thats truly divine, $MOSES is here to guide the faithful on Sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Moses_f71bc85d9d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOSES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOSES>>(v1);
    }

    // decompiled from Move bytecode v6
}

