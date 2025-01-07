module 0x2dd5af8f0bd7e62695773bc516a79e6e198895563a3c49e9b57ecfc52bf5b157::aaadodo {
    struct AAADODO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAADODO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAADODO>(arg0, 6, b"AAADODO", b"AAADODO SUI", x"24616161444f444f205468696e6b696e672069732077686174206d616b6573207573207269636820696e207468652067616d652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_01_36_58_c4f6eeccab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAADODO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAADODO>>(v1);
    }

    // decompiled from Move bytecode v6
}

