module 0x9fbc14edea7fa4c6f395b9cdd3c84e828a5a237f5b44c42cdaa00274cf659c7f::cuttlefish {
    struct CUTTLEFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUTTLEFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUTTLEFISH>(arg0, 6, b"CUTTLEFISH", b"Cuttle Fish", b"The Cuttle Fish is a sneaky, color changing creature that lives in the deep Sui oceans.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cuttlefish_f9ec97c356.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUTTLEFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUTTLEFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

