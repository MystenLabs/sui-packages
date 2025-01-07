module 0x91abc5ea329d1cf4d3bb481d41f23018ecdb6b075b4a87e63fa458cf50950d32::nl {
    struct NL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NL>(arg0, 6, b"NL", b"NaiLong", b"https://www.douyin.com/user/MS4wLjABAAAAA_GQLUmv6kfmHaqOwyg3znCzA6eGO1fMsdTLaWp_PMXiNCo3tje6XmG9fmbstwFZ?from_tab_name=main", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mosaic_legacy_2ed54000337d7f18b860a_c5_300x300_ee1743ce6c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NL>>(v1);
    }

    // decompiled from Move bytecode v6
}

