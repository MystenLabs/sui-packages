module 0x633ffed383b5a6632db3e64186deac323aa4aab807084b13428d72afc14705bc::luma {
    struct LUMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUMA>(arg0, 6, b"LUMA", b"LUMACORN", b"You didnt come this far to stop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_024733579_12f777167e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

