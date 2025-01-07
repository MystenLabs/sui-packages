module 0xfda55f49eb4726a0d0264f6a6c35821272e27f57bd0d57ec12344df28c29c3c6::kml {
    struct KML has drop {
        dummy_field: bool,
    }

    fun init(arg0: KML, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KML>(arg0, 6, b"KML", b"Crypto Kemal", b"KML, Trkiye'nin en byk kripto traderi Crypto Kemal'in vizyonunu paylamak amacyla NST holderlar tarafndan bir fan token olarak yaratlmtr. Hadi KML ailesi, hep birlikte kazanalm! KML was created as a fan token by NST holders to share the vision of Turkey's largest crypto trader Crypto Kemal. Come on KML family, let's win together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4567567_9e8eafa594.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KML>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KML>>(v1);
    }

    // decompiled from Move bytecode v6
}

