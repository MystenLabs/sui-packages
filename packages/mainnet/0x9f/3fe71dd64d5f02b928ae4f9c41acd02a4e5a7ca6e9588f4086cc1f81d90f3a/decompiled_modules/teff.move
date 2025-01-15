module 0x9f3fe71dd64d5f02b928ae4f9c41acd02a4e5a7ca6e9588f4086cc1f81d90f3a::teff {
    struct TEFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEFF>(arg0, 6, b"Teff", b"Teff rocket friend", x"0a49616d2074656666202c20726f636b657420667269656e642c20796f757220636f736d696320667269656e6420736f6172696e67207468726f756768207468652063727970746f20736b6965732e0a506f7765726564206279205375692c2049276d206865726520746f20626f6f737420796f7572206a6f75726e6579207769746820737065656420616e6420696e6e6f766174696f6e2e0a486f70206f6e20616e64206c657427732074616b6520796f757220706f7274666f6c696f20746f20746865206d6f6f6e20746f67657468657221220a0a0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000015356_2ae56dc829.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

