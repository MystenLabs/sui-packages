module 0xe532be1d3530bebe1127259a17d8fe98e2e120cff28ecd326dce0f7990a92ed::wen {
    struct WEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEN>(arg0, 6, b"Wen", b"Wensui", b"Bringing sol to Sui...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000204157_959a638b6d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

