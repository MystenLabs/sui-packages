module 0xf770a9d086102ed5acc2528aabb06d60df4d1b7c6b97a97f5cb76b42ad4f4c5d::suitank {
    struct SUITANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITANK>(arg0, 9, b"SUITANK", b"SUITANK", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUITANK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITANK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITANK>>(v1);
    }

    // decompiled from Move bytecode v6
}

