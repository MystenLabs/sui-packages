module 0xf209907437693dcd64fc242dc866594fe2f4ae352fdaa0938beceeb287fc3b0a::boysclub {
    struct BOYSCLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOYSCLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOYSCLUB>(arg0, 9, b"BOYSCLUB", b"Boys Club On Sui", b"Boys Club", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://assets.zyrosite.com/cdn-cgi/image/format=auto,w=451,h=451,fit=crop/mxBZ1WV4vvU8Olpk/untitled-2-m5KwxoNJj7TzPl82.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOYSCLUB>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOYSCLUB>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOYSCLUB>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

