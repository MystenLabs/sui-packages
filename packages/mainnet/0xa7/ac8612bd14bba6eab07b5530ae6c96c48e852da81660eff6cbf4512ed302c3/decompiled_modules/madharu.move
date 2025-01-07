module 0xa7ac8612bd14bba6eab07b5530ae6c96c48e852da81660eff6cbf4512ed302c3::madharu {
    struct MADHARU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MADHARU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MADHARU>(arg0, 6, b"MADHARU", b"Mad Miharu", b"Madharu was created because there are too many MIHARU tokens on SUI, SLOWLANA, and JEETHEREUM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/madharu_8b9e7c0f19.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MADHARU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MADHARU>>(v1);
    }

    // decompiled from Move bytecode v6
}

