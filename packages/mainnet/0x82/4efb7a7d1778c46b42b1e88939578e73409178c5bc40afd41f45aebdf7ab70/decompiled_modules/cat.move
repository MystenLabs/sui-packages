module 0x824efb7a7d1778c46b42b1e88939578e73409178c5bc40afd41f45aebdf7ab70::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT>(arg0, 6, b"CAT", b"SUIYAN CAT", x"416e797468696e6720796f7520736565206f6e206d6f766570756d702069732066616b6573202e20546865206f6e6c79206c696e6b2077696c6c20626520706f7374656420686572652e204765742068797065722e0a0a466f6c6c6f772058207768696c6520796f75206174206974202d20782e636f6d2f73756979616e6361740a0a4e61206e61206e61206e61206e61206e61206e61206e61206e61", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suicat_afaa8c5671_50a505ee29.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

