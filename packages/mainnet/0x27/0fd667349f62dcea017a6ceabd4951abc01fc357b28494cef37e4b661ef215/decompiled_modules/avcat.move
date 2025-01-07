module 0x270fd667349f62dcea017a6ceabd4951abc01fc357b28494cef37e4b661ef215::avcat {
    struct AVCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVCAT>(arg0, 6, b"AVCAT", b"Avocado Cat", b"Cat? Avocado? Avocado Cat!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/profilll_fd19b8c032.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AVCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

