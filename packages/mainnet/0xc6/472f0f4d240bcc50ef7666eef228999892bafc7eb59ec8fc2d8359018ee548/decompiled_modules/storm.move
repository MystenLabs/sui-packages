module 0xc6472f0f4d240bcc50ef7666eef228999892bafc7eb59ec8fc2d8359018ee548::storm {
    struct STORM has drop {
        dummy_field: bool,
    }

    fun init(arg0: STORM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STORM>(arg0, 9, b"STORM", b"STORM", b"Some Therapy Or Risk Management", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.corporatefinanceinstitute.com/assets/risk3-1024x464.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STORM>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STORM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STORM>>(v1);
    }

    // decompiled from Move bytecode v6
}

