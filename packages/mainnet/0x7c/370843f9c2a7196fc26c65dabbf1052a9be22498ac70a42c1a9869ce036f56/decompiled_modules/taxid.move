module 0x7c370843f9c2a7196fc26c65dabbf1052a9be22498ac70a42c1a9869ce036f56::taxid {
    struct TAXID has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAXID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TAXID>(arg0, 6, b"TAXID", b"TAXI DRIVER", b"Is a meme from the movie taxi driver", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000060106_f3001576a4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TAXID>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAXID>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

