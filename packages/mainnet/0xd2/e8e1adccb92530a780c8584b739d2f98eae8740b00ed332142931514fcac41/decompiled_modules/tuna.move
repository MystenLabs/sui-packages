module 0xd2e8e1adccb92530a780c8584b739d2f98eae8740b00ed332142931514fcac41::tuna {
    struct TUNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUNA>(arg0, 6, b"TUNA", b"TUNA TURNER", x"54484953204f4646494349414c202454554e410a54756e61205475726e65722c2074686520756e726976616c656420517565656e206f6620537569204f6365616e2c20636f6d6d616e647320746865207761766573207769746820686572206361707469766174696e6720766f69636520616e6420756e73746f707061626c6520656e65726779", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0873_4182044eaf.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

