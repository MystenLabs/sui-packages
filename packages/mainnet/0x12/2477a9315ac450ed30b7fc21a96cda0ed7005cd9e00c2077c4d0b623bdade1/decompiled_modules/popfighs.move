module 0x122477a9315ac450ed30b7fc21a96cda0ed7005cd9e00c2077c4d0b623bdade1::popfighs {
    struct POPFIGHS has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPFIGHS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPFIGHS>(arg0, 6, b"POPFIGHS", b"Pop Fish's", b"PopFish on SUI pop pop pop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pop_Fish_s_98629de71e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPFIGHS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPFIGHS>>(v1);
    }

    // decompiled from Move bytecode v6
}

