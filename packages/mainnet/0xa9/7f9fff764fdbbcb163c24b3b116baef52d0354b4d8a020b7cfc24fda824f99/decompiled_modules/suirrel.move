module 0xa97f9fff764fdbbcb163c24b3b116baef52d0354b4d8a020b7cfc24fda824f99::suirrel {
    struct SUIRREL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRREL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRREL>(arg0, 6, b"Suirrel", b"Squirrel the Sui Squirrel", b"Squeeeeeeek", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030718_ebc55666c8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRREL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRREL>>(v1);
    }

    // decompiled from Move bytecode v6
}

