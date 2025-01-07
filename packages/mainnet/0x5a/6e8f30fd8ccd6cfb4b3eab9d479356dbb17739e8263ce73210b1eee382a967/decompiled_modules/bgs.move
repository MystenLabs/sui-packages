module 0x5a6e8f30fd8ccd6cfb4b3eab9d479356dbb17739e8263ce73210b1eee382a967::bgs {
    struct BGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BGS>(arg0, 6, b"BGS", b"Beast Games Sui", x"24424753202d2042656173742047616d65732053554920666f72207472756520646567656e732120594f552063616e2077696e20757020746f2024352c3030302c30303020696e207072697a657321204a554d5020494e20414e442054414b4520544845205448524f4e452e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241221_134324_596_d800f689d5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

