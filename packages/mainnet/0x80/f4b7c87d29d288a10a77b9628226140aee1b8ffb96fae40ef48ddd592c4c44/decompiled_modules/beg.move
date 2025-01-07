module 0x80f4b7c87d29d288a10a77b9628226140aee1b8ffb96fae40ef48ddd592c4c44::beg {
    struct BEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEG>(arg0, 6, b"BEG", b"Beggar", b"BEG on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FJH_Jo_K0i_400x400_95dbfbb8d4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEG>>(v1);
    }

    // decompiled from Move bytecode v6
}

