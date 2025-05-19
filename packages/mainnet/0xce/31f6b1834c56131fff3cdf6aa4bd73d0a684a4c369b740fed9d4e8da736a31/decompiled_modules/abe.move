module 0xce31f6b1834c56131fff3cdf6aa4bd73d0a684a4c369b740fed9d4e8da736a31::abe {
    struct ABE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABE>(arg0, 9, b"ABE", b"AYOUB", b"This is the first ever memetoken on memedexx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.recrd.com/discover?post_id=752522d0-d06f-11ef-a7c7-0d596bc7aa3f")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ABE>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABE>>(v2, @0xcd77bc1e00ce9b6eb15bbd89d7e4521330c5fa8a170da7d12081a1d0b003a95);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ABE>>(v1);
    }

    // decompiled from Move bytecode v6
}

