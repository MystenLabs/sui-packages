module 0x53de9c4e432a78e0c3433e225c62f69da54fa888148fd73f1a572aa16593e138::sudeng {
    struct SUDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUDENG>(arg0, 6, b"SUDENG", b"Sui Deng", b"$SuDeng The close family of $Moodeng is now here with the ambition to be at the top of the sui ecosystem with a solid and strong community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241125_235740_a937673ac5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

