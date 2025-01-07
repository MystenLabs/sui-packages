module 0xc83c32b5328a9728e1e9df8c6954e1138cc0d5bada8fa96063e09d1c24e6eeee::prk {
    struct PRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRK>(arg0, 6, b"PRK", b"PupRocket on sui", b"With the continuous development of the cryptocurrency market and the support of Sui Network, PupRocket promises to bring attractive profits to investors.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_626241b369.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRK>>(v1);
    }

    // decompiled from Move bytecode v6
}

