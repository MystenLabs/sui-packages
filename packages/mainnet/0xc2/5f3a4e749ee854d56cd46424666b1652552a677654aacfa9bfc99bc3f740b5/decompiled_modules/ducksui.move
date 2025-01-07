module 0xc25f3a4e749ee854d56cd46424666b1652552a677654aacfa9bfc99bc3f740b5::ducksui {
    struct DUCKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKSUI>(arg0, 6, b"DUCKSUI", b"DUCKSUI!", x"41686f7921204361707461696e20244455434b5355492077617320796f7572206176657261676520706972617465206475636b20706c756e646572696e672073686970732c2064696767696e672075702074726561737572652c20616e642073687566666c696e6720696e746f2074726f75626c652e20427574206f6e65206461792c20696e7374656164206f6620676f6c642c20686520637261636b6564206f70656e20612063686573742066756c6c206f6620737472616e676520676c6f77696e6720636f696e7321205475726e73206f75742c20686520686164206a75737420646973636f76657265642063727970746f210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_09_13_10_45_ca497a0fef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

