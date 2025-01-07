module 0x8c4a9cc4fdab76435d670f249ff812eb56b65f7203dbce5498ed320ba555f7bf::akita {
    struct AKITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKITA>(arg0, 6, b"AKITA", b"Akita", b"One and only AKITA! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b603280c_18d5_4194_a9c9_5a06902c26f3_6f0f390a47.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AKITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

