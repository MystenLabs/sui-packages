module 0xb47116e7a10ec28fdd64733269cd469de3a1d07e97977b4ec402b76d50c572c4::wwe {
    struct WWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWE>(arg0, 6, b"WWE", b"WE WRESTLE EVERYTHING OFFICIAL", b"No prelaunch, no team allocationjust pure degen chaos in a steel-cage throwdown!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_3xnei3_400x400_76a5fe1896.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

