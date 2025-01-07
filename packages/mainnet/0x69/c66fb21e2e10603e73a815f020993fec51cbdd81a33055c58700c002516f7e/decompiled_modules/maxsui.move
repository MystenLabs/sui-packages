module 0x69c66fb21e2e10603e73a815f020993fec51cbdd81a33055c58700c002516f7e::maxsui {
    struct MAXSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAXSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAXSUI>(arg0, 6, b"MAXSUI", b"MAXSUI CTO", b"MAXSUI CTO - Sent Maxi to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MAXI_20fb08b24a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAXSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAXSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

