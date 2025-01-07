module 0xa7182edb7f1f51bdf5798af1f7312a0c15aff9e605d8af4680da787cf2b03501::hippotoshi {
    struct HIPPOTOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPOTOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPOTOSHI>(arg0, 6, b"Hippotoshi", b"Hippotoshi (The Real Nakamoto)", x"546865207265616c205361746f736869204e616b616d6f746f2e200a0a4e6f7420616e206f6c64206d616e2e0a0a4e6f7420736f6d65206e6572647920677579207468617420616c72656164792070617373656420617761792e0a0a4974277320612066636b696e6720686970706f2077686f2773207265616c206e616d6520697320486970706f746f736869", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_6062113418388816833_x_1_2a532a78b4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPOTOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPPOTOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

