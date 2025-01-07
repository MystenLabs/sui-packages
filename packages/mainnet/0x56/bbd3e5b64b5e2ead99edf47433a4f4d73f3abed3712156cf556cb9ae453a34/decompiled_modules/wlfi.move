module 0x56bbd3e5b64b5e2ead99edf47433a4f4d73f3abed3712156cf556cb9ae453a34::wlfi {
    struct WLFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WLFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLFI>(arg0, 6, b"WLFI", b"World Liberty Financial", x"446f6e616c64204a2e205472756d702c2074686520666972737420707265736964656e7420746f206c61756e636820612063727970746f63757272656e63790a4974277320746f6b656e206e616d6520697320576f726c64204c6962657274792046696e616e6369616c2028574c464929", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/30_Q2_SFVH_400x400_1970d3a150.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WLFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WLFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

