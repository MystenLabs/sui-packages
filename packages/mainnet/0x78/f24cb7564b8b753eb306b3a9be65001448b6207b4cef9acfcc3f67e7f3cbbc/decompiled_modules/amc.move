module 0x78f24cb7564b8b753eb306b3a9be65001448b6207b4cef9acfcc3f67e7f3cbbc::amc {
    struct AMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMC>(arg0, 6, b"AMC", b"AMC ON SUI", b"Changing the world! AMC ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nakamigos_aa1848d40d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

