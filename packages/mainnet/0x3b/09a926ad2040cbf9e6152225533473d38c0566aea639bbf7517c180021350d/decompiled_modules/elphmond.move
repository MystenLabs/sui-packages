module 0x3b09a926ad2040cbf9e6152225533473d38c0566aea639bbf7517c180021350d::elphmond {
    struct ELPHMOND has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELPHMOND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELPHMOND>(arg0, 6, b"ELPHMOND", b"ELEPHANTDIAMOND", b"he holding the diamond!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/UP_6tmo_Gu_400x400_copy_f28de27bfd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELPHMOND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELPHMOND>>(v1);
    }

    // decompiled from Move bytecode v6
}

