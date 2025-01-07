module 0xdaf3e7fc568c98118c74f60deb241c00c87faac2824c9cd18fffc1a39ea51528::lax {
    struct LAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAX>(arg0, 6, b"LAX", b"Laxfed", b"Laxfed Paulacy, a persona born from a critique of \"lackadaisical federal policies,\" embodies the intersection of culinary arts, cryptocurrency analysis, Python programming, and insightful commentary on federal governance. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/laxfed_55cc98a0cc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAX>>(v1);
    }

    // decompiled from Move bytecode v6
}

