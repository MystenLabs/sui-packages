module 0x335641e6523c39493c29b754be77a92bbceda1e26dce25393994699bfff2aa0f::commo {
    struct COMMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: COMMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COMMO>(arg0, 6, b"COMMO", b"Sui Commo", b"COMMO is the first Sui meme coin created through the collaboration of human creativity and AI technology", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250502_151922_4bc5a3a37b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COMMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COMMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

