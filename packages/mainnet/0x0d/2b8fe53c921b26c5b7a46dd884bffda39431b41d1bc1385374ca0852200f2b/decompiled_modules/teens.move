module 0xd2b8fe53c921b26c5b7a46dd884bffda39431b41d1bc1385374ca0852200f2b::teens {
    struct TEENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEENS>(arg0, 6, b"TEENS", b"SUI-TEENS", b"A group of teens hanging out on the #SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/teen_0c3a396e8a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEENS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEENS>>(v1);
    }

    // decompiled from Move bytecode v6
}

