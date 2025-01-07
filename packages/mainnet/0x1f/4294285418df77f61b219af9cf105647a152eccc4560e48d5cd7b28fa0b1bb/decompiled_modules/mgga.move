module 0x1f4294285418df77f61b219af9cf105647a152eccc4560e48d5cd7b28fa0b1bb::mgga {
    struct MGGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MGGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MGGA>(arg0, 6, b"MGGA", b"Make Games Great Again", x"4d616b652047616d657320477265617420416761696e0a5265766976696e672074686520737069726974206f662067616d696e67206f6e20537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000505339_794a979a7f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MGGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MGGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

