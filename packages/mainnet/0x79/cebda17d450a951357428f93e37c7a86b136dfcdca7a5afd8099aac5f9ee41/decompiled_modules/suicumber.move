module 0x79cebda17d450a951357428f93e37c7a86b136dfcdca7a5afd8099aac5f9ee41::suicumber {
    struct SUICUMBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICUMBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICUMBER>(arg0, 6, b"SUICUMBER", b"Suicumber", x"53756963756d6265722069736e277420626c75652c20736f20776861743f2077696c6c20746861742073746f702068696d2066726f6d206265636f6d696e67206f6e65206f6620535549277320626573743f204365727461696e6c79206e6f742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_21_50_36_724673ec50.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICUMBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICUMBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

