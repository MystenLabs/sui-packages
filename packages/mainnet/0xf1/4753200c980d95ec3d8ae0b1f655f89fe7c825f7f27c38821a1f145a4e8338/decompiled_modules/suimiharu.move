module 0xf14753200c980d95ec3d8ae0b1f655f89fe7c825f7f27c38821a1f145a4e8338::suimiharu {
    struct SUIMIHARU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMIHARU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMIHARU>(arg0, 6, b"SUIMiharu", b"Miharu", b"me when I see there have been over 32M impressions of this meme on X", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009897_90b8a96ddd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMIHARU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMIHARU>>(v1);
    }

    // decompiled from Move bytecode v6
}

