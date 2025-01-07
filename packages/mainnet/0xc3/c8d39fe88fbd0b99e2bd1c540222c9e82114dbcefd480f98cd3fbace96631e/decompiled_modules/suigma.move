module 0xc3c8d39fe88fbd0b99e2bd1c540222c9e82114dbcefd480f98cd3fbace96631e::suigma {
    struct SUIGMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGMA>(arg0, 6, b"SUIGMA", b"suigma", b"suigma male", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Patrick_Bateman_Pfp_HD_95b5119622.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

