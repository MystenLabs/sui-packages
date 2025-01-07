module 0xd5af3b9dc6ad8dc53b14933107314056c95a3d29610d23b54bdcc35d846d96ae::clauzz {
    struct CLAUZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLAUZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLAUZZ>(arg0, 6, b"CLAUZZ", b"Santas Huzz AI", x"24434c41555a5a202853616e7461732048757a7a29206973206865726520746f206d616b6520796f7572204368726973746d61732077697368657320636f6d6520747275652e2e2e0a0a583a2068747470733a2f2f782e636f6d2f436c61757a7a41490a54656c656772616d3a2068747470733a2f2f742e6d652f436c61757a7a41490a576562736974653a2068747470733a2f2f636c61757a7a2e66756e2f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241229_051749_992_06de532ed3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLAUZZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLAUZZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

