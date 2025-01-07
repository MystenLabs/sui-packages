module 0x291a839ee1a92833bffc5e3fbe6fc8413c2b6779b3611bacbdc500376015dce9::babyflokisui {
    struct BABYFLOKISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYFLOKISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYFLOKISUI>(arg0, 6, b"Babyflokisui", b"Baby floki sui", b"Baby floki on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000906367_6c89b4d641.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYFLOKISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYFLOKISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

