module 0x8ed3563f74decc61c2ff3af9a1b9b2ed209a1de1aa717a41eee315a866f2a175::xmasui {
    struct XMASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: XMASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XMASUI>(arg0, 6, b"XMASUI", b"Christmas Spirit on SUI", b"Merry Christmas Everyone!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5h23grat_400x400_e236a4c908.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XMASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XMASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

