module 0xe8ce98dd8c899e9c23662425f8e221954a2f9cdf4cc5a8b6d9736762ad93671f::skicat {
    struct SKICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKICAT>(arg0, 9, b"SKICAT", b"SKI MASK CAT", b"SKI MASK CAT meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreib75ku7etpwzwytj2aylyobrsdxlkirg6lhkhzoas4crufokdcm3y.ipfs.w3s.link")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SKICAT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKICAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKICAT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

