module 0x4383f644e7dff6b1f9b6d8240fbf9a23a677d8dd8dee01503efad805cb689c5f::bubba {
    struct BUBBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBBA>(arg0, 9, b"BUBBA", b"BUBNAGUMP", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUBBA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

