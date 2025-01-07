module 0x5ddf8e075cda06ea5899342d388046731f56d28d402bdb5b164316b7323e4cc4::suimonkey {
    struct SUIMONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMONKEY>(arg0, 9, b"SUIMONKEY", b"SUIMONKEY", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIMONKEY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMONKEY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMONKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

