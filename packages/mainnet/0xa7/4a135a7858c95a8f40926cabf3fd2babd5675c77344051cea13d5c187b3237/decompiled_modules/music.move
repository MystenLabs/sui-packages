module 0xa74a135a7858c95a8f40926cabf3fd2babd5675c77344051cea13d5c187b3237::music {
    struct MUSIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSIC>(arg0, 6, b"MUSIC", b"Music On Sui", b"First token for Music On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1200x630wa_c50005e64d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUSIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

