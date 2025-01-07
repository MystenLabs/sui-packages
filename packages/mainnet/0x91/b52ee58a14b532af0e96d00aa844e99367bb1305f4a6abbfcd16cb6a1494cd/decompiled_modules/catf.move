module 0x91b52ee58a14b532af0e96d00aa844e99367bb1305f4a6abbfcd16cb6a1494cd::catf {
    struct CATF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATF>(arg0, 6, b"CATF", b"CatFrog on Sui", b"$CATF is the treasure you've been looking for!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4f399a5f_1ed4_4113_8deb_330b76ac9e68_4ec0d98f73.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATF>>(v1);
    }

    // decompiled from Move bytecode v6
}

